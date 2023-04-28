import UIKit
import FirebaseAuth

class FavouritesTableViewController: UITableViewController, RecipePresenting {

    private var searchController: UISearchController?
    private var recipe: Recipe?
    private var recipes = [Recipe]()
    private var authHandle: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
        configureSearchController()

        authHandle = Auth.auth().addStateDidChangeListener({ [weak self] auth, user in
            FavouritesManager.getFavourites { favourites in
                DispatchQueue.main.async {
                    self?.recipes = favourites
                    self?.tableView.reloadData()
                }
            }
        })
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        let item = recipes[indexPath.row]
        cell.recipeView.configure(item: item)
        cell.setHasLargeImage(true)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = recipes[indexPath.row]
        showRecipe(item)
    }
}

extension FavouritesTableViewController {
    private func configureTableView() {
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeTableViewCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }

    private func configureNavigationBar() {
        title = "Favourites"
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "icon.left")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "icon.left")
        navigationController?.navigationBar.tintColor = UIColor(named: "black")
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }

    private func configureSearchController() {
        let searchResults = AllRecipesTableViewController()
        searchResults.source = .favourite
        searchController = UISearchController(searchResultsController: searchResults)
        searchController?.searchResultsUpdater = searchResults
        navigationItem.searchController = searchController
        searchController?.searchBar.placeholder = "Search"
    }
}
