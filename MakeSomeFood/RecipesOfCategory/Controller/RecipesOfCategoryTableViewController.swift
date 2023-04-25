import UIKit

class RecipesOfCategoryTableViewController: UITableViewController, RecipePresenting {

    var categoryName: String!
    var tagsType: TagsType!
    private var recipeOfCategory: [RecipeOfCategory] = []
    let apiManager = ApiManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()

        apiManager.getRecipes(filterId: tagsType.filterId, value: categoryName){ [weak self] result in
            switch result {
            case .success(let recipesOfCategoryList):
                DispatchQueue.main.async {
                    self?.recipeOfCategory = recipesOfCategoryList.meals
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeOfCategory.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        cell.hideTags(true)
        cell.setHasLargeImage(false)
        let item = recipeOfCategory[indexPath.row]
        cell.recipeView.configure(item: item)
        cell.selectionStyle = .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = recipeOfCategory[indexPath.row]
        apiManager.getRecipeById(id: item.id){ [weak self] result in
            switch result {
            case .success(let recipesOfCategoryList):
                DispatchQueue.main.async {
                    guard let recipe = recipesOfCategoryList.meals.first else { return }
                    self?.showRecipe(recipe)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }

    private func configure() {
        configureTableView()
        configureNavigationBar()
    }
}

extension RecipesOfCategoryTableViewController {
    private func configureTableView() {
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeTableViewCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }

    private func configureNavigationBar() {
        title = categoryName
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "icon.left")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "icon.left")
        navigationController?.navigationBar.tintColor = UIColor(named: "black")
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}
