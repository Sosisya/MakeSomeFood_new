import UIKit

class HomeTableViewController: UITableViewController {

    enum Section: Int, CaseIterable {
        case greeting
        case specilRecipe
        case categories
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
    }

    private func configureNavigationBar() {
        title = "Home"
    }

    private func configureTableView() {
        tableView.register(GreetingTableViewCell.self, forCellReuseIdentifier: "GreetingTableViewCell")
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeTableViewCell")
        tableView.register(CategorieTableViewCell.self, forCellReuseIdentifier: "CategorieTableViewCell")
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.separatorStyle = .none
    }
}

extension HomeTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .greeting:
            return 1
        case .specilRecipe:
            return 1
        case .categories:
            return 10
        default:
            fatalError()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section) {
        case .greeting:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GreetingTableViewCell", for: indexPath) as! GreetingTableViewCell
            return cell
        case .specilRecipe:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
            return cell
        case .categories:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategorieTableViewCell", for: indexPath) as! CategorieTableViewCell
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
        case .greeting:
            return nil
        case.specilRecipe:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
            return header
        case .categories:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
            return header
        default:
            fatalError()
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //        UITableView.automaticDimension
        switch Section(rawValue: section) {
        case .greeting:
            return 0
        case .specilRecipe:
            return UITableView.automaticDimension
        case .categories:
            return UITableView.automaticDimension
        default:
            fatalError()
        }
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        //        UITableView.automaticDimension
        switch Section(rawValue: section) {
        case .greeting:
            return 0
        case .specilRecipe:
            return UITableView.automaticDimension
        case .categories:
            return UITableView.automaticDimension
        default:
            fatalError()
        }
    }
}

