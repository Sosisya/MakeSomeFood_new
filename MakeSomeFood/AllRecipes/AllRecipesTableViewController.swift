import UIKit
import Kingfisher

class AllRecipesTableViewController: UITableViewController, RecipePresenting {
    private var apiManager = ApiManager()
    var categoryName: String!
    private var recipe: [Recipe] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
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
}

extension AllRecipesTableViewController {
    private func configureTableView() {
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeTableViewCell")
        tableView.separatorStyle = .none
    }

    private func configureNavigationBar() {
        title = "All recipes"
    }

    private func getAllRecipes() {
        apiManager.getAllRecipes(search: "") { [weak self] result in
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
}
