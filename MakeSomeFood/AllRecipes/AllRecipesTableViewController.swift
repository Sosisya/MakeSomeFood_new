import UIKit
import Kingfisher

class AllRecipesTableViewController: UITableViewController, RecipePresenting {

    enum Source {
        case favourite
        case allRecipes
    }


    private var apiManager = ApiManager()
    var categoryName: String!
    private var recipe: [Recipe] = []
    public var source: Source = .allRecipes
    public var search: String = "" {
        didSet {
            refreshSearchResults()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        refreshSearchResults()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        cell.selectionStyle = .none
        let item = recipe[indexPath.row]
        let url = URL(string: item.thumb ?? "")
        cell.recipeView.recipeImageView.kf.setImage(with: url)
        cell.recipeView.nameOfRecipeLabel.text = item.name
        cell.recipeView.areaTagLabel.text = item.area
        cell.recipeView.categoryTagLabel.text = item.category
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = recipe[indexPath.row]
        showRecipe(item)
    }

    private func configure() {
        configureTableView()
        configureNavigationBar()
        getAllRecipes()
    }

    private func refreshSearchResults() {
        switch source {
        case .allRecipes: getAllRecipes()
        case .favourite: getFavouriteRecipes()
        }
    }
}

extension AllRecipesTableViewController {
    private func configureTableView() {
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeTableViewCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }

    private func configureNavigationBar() {
        title = "All recipes"
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "icon.left")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "icon.left")
        navigationController?.navigationBar.tintColor = UIColor(named: "black")
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }

    private func getAllRecipes() {
        apiManager.getAllRecipes(search: search) { [weak self] result in
            switch result {
            case .success(let recipes):
                DispatchQueue.main.async {
                    self?.recipe = recipes.meals
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func getFavouriteRecipes() {
        FavouritesManager.getFavourites { [weak self] favourites in
            DispatchQueue.main.async {
                guard let self else { return }
                self.recipe = favourites.filter { $0.name.lowercased().contains(self.search.lowercased()) }
                self.tableView.reloadData()
            }
        }
    }
}

extension AllRecipesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.search = searchController.searchBar.text ?? ""
    }
}
