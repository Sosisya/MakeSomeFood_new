import UIKit
import Kingfisher
import FirebaseAuth

class HomeTableViewController: UITableViewController, RecipePresenting {
    // - MARK: -
    enum Section: Int, CaseIterable {
        case specialRecipe
        case categories
    }
    // - MARK: Costants
    struct Spec {
        static let backIndicatorImage = UIImage(named: "icon.left")
        static let backIndicatorTransitionMaskImage = UIImage(named: "icon.left")
        static let searchBarPlaceholder = "Search"
        static let specialHeaderLabelTitle = "Special"
        static let specialHeaderButtonTitle = "All recipes"
        static let categoryHeaderTitle = "Categories"
    }

    // - MARK: -
    let apiManager = ApiManager()
    private var categories: [Category] = []
    var recipe: Recipe?
    private var searchController: UISearchController?
    private let specialRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()

    // - MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        configureHomeHeader()
        getCategories()
        getRecipe()
        configureRefreshControl()
        configureSearchController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateHeader()
    }

    private func updateHeader() {
        guard let user = Auth.auth().currentUser,
              let header = tableView.tableHeaderView as? HomeTableHeaderView
        else {
            return
        }
        header.refreshUser(user)
    }
}

// - MARK: -
extension HomeTableViewController {
    // - MARK: Network
    private func getCategories() {
        apiManager.getCategoryList { [weak self] result in
            switch result {
            case .success(let categoriesList):
                DispatchQueue.main.async {
                    self?.categories = categoriesList.categories
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getRecipe() {
        apiManager.getRecipe { [weak self] result in
            switch result {
            case .success(let recepieList):
                DispatchQueue.main.async {
                    self?.recipe = recepieList.meals.first
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // - MARK: Configure
    private func configureNavigationBar() {
        navigationController?.navigationBar.backIndicatorImage = Spec.backIndicatorImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = Spec.backIndicatorTransitionMaskImage
        navigationController?.navigationBar.tintColor = .specialBlack
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }

    private func configureTableView() {
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeTableViewCell")
        tableView.register(CategorieTableViewCell.self, forCellReuseIdentifier: "CategorieTableViewCell")
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.refreshControl = specialRefreshControl
    }

    private func configureHomeHeader() {
        let headerView = HomeTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 58))
        tableView.tableHeaderView = headerView
    }

    private func configureSearchController() {
        let searchResults = AllRecipesTableViewController()
        searchController = UISearchController(searchResultsController: searchResults)
        searchController?.searchResultsUpdater = searchResults
        navigationItem.searchController = searchController
        searchController?.searchBar.placeholder = Spec.searchBarPlaceholder
    }

    private func configureRefreshControl() {
        specialRefreshControl.addTarget(self, action: #selector(refreshSpecial), for: .valueChanged)
    }

    @objc private func refreshSpecial(sender: UIRefreshControl) {
        apiManager.getRecipe { [weak self] result in
            switch result {
            case .success(let recepieList):
                DispatchQueue.main.async {
                    self?.recipe = recepieList.meals.first
                    self?.tableView.reloadData()
                    sender.endRefreshing()
                }
            case .failure(let error):
                print(error.localizedDescription)
                sender.endRefreshing()
            }
        }
    }
}

// - MARK: UITableViewDelegate, UITableViewDataSource
extension HomeTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .specialRecipe:
            return 1
        case .categories:
            return categories.count
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section) {
        case .specialRecipe:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
            cell.selectionStyle = .none
            cell.recipeView.nameOfRecipeLabel.text = recipe?.name
            let url =  URL(string: recipe?.thumb ?? "")
            cell.recipeView.recipeImageView.kf.setImage(with: url)
            cell.recipeView.areaTagLabel.text = recipe?.area
            cell.recipeView.categoryTagLabel.text = recipe?.category
            cell.recipeView.recipe = recipe
            if let recipe {
                cell.recipeView.configure(item: recipe)
            }
            cell.recipeView.setIsFavourite(false)
            return cell
        case .categories:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategorieTableViewCell", for: indexPath) as! CategorieTableViewCell
            cell.selectionStyle = .none
            let item = categories[indexPath.row]
            cell.categorieLabel.text = item.category
            let url = URL(string: item.thumb)
            cell.categorieImageView.kf.setImage(with: url)
            return cell
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch Section(rawValue: section) {
        case.specialRecipe:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
            header.configure(title: Spec.specialHeaderLabelTitle, actionTitle:  Spec.specialHeaderButtonTitle) {
                let allRecipesVC = AllRecipesTableViewController()
                self.show(allRecipesVC, sender: self)
            }
            return header
        case .categories:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
            header.configure(title: Spec.categoryHeaderTitle)
            return header
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch Section(rawValue: section) {
        case .specialRecipe:
            return UITableView.automaticDimension
        case .categories:
            return UITableView.automaticDimension
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        switch Section(rawValue: section) {
        case .specialRecipe:
            return UITableView.automaticDimension
        case .categories:
            return UITableView.automaticDimension
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Section(rawValue: indexPath.section) {
        case .specialRecipe:
            guard let recipe = recipe else { return }
            showRecipe(recipe)
        case .categories:
            guard indexPath.section == 1 else { return }
            showRecipes(.category, categories[indexPath.row].category)
        default:
            fatalError()
        }
    }
}


