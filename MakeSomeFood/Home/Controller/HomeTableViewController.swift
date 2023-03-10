import UIKit
import Kingfisher
class HomeTableViewController: UITableViewController {
    
    let apiManager = ApiManager()
    private var categories: [Category] = []
    var recipe: Recipe?
    
    enum Section: Int, CaseIterable {
        //        case greeting
        case specialRecipe
        case categories
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        getCategories()
        getRecipe()
    }
    
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
        title = ""
    }
    
    private func configureTableView() {
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
            //        case .greeting:
            //            return 1
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
            //        case .greeting:
            //            let cell = tableView.dequeueReusableCell(withIdentifier: "GreetingTableViewCell", for: indexPath) as! GreetingTableViewCell
            //            cell.selectionStyle = .none
            //            return cell
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
            //        case .greeting:
            //            return nil
        case.specialRecipe:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
            header.configure(title: "Special", actionTitle: "All recipes") {
                let recipeVC = AllRecipesTableViewController()
                self.present(recipeVC, animated: true)
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
            //        case .greeting:
            //            return 0
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
            //        case .greeting:
            //            return 0
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
            self.present(recipeVC, animated: true)
        case .categories:
            print("category")
        default:
            fatalError()
        }
    }
}
