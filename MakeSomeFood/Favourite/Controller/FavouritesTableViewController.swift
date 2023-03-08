import UIKit

class FavouritesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        cell.setHasLargeImage(false)
        cell.selectionStyle = .none
        return cell
    }
}

extension FavouritesTableViewController {
    private func configureTableView() {
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeTableViewCell")
    }
    private func configureNavigationBar() {
        title = "Favourites"
    }
}
