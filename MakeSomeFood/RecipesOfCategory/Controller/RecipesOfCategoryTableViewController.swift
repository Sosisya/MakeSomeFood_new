import UIKit

class RecipesOfCategoryTableViewController: UITableViewController {

    var categoryName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        cell.hideTags(true)
        cell.setHasLargeImage(false)
        cell.selectionStyle = .none
        return cell
    }

    private func configure() {
        configureTableView()
        configureNavigationBar()
    }
}

extension RecipesOfCategoryTableViewController {
    private func configureTableView() {
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeTableViewCell")
    }

    private func configureNavigationBar() {
        title = categoryName
    }
}
