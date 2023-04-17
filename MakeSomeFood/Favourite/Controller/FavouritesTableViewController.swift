import UIKit

class FavouritesTableViewController: UITableViewController {

    private var searchController: UISearchController?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
        configureSearchController()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        cell.setHasLargeImage(true)
        cell.selectionStyle = .none
        return cell
    }
}

extension FavouritesTableViewController {
    private func configureTableView() {
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeTableViewCell")
        tableView.separatorStyle = .none
    }

    private func configureNavigationBar() {
        title = "Favourites"
    }

    private func configureSearchController() {
        let searchResults = AllRecipesTableViewController()
        searchController = UISearchController(searchResultsController: searchResults)
        navigationItem.searchController = searchController
        searchController?.searchBar.placeholder = "Search"
    }
}
