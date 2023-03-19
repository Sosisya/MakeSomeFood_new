import UIKit
import Kingfisher

class HomeTableViewController: UITableViewController {
    enum Section: Int, CaseIterable {
        case specialRecipe
        case categories
    }

    struct Spec { }
    
    let apiManager = ApiManager()
    private var categories: [Category] = []
    var recipe: Recipe?
    private var searchController: UISearchController?

    private let specialRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()

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
}

extension HomeTableViewController {
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
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "icon.left")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "icon.left")
        navigationController?.navigationBar.tintColor = UIColor(named: "black")
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    private func configureTableView() {
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeTableViewCell")
        tableView.register(CategorieTableViewCell.self, forCellReuseIdentifier: "CategorieTableViewCell")
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        
        tableView.separatorStyle = .none

        tableView.refreshControl = specialRefreshControl
    }

    private func configureHomeHeader() {
        let headerView = HomeTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 58))
        tableView.tableHeaderView = headerView
    }

    private func configureSearchController() {
        let searchResults = AllRecipesTableViewController()
        searchController = UISearchController(searchResultsController: searchResults)
        navigationItem.searchController = searchController
        searchController?.searchBar.placeholder = "Search"
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
            header.configure(title: "Special", actionTitle: "All recipes") {
                let allRecipesVC = AllRecipesTableViewController()
                allRecipesVC.title = "All recipes"
                self.show(allRecipesVC, sender: self)
            }
            return header
        case .categories:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
            header.configure(title: "Categories")
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
            let recipeVC = CookingViewController()
            show(recipeVC, sender: self)
        case .categories:
            let recipesOfCategoriesVC = RecipesOfCategoryTableViewController()
            let item = categories[indexPath.row].category
            recipesOfCategoriesVC.categoryName = item
            show(recipesOfCategoriesVC, sender: self)
        default:
            fatalError()
        }
    }
}
