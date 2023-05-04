import UIKit
import Kingfisher

class SearchCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, RecipePresenting {
    // - MARK: -
    enum Section: Int, CaseIterable {
        case category
        case area
        case ingredient
        case allRecipes
    }

    // - MARK: Constants
    struct Spec {
        static var collectionViewLayoutHeight: CGFloat = 42
        static var countOfTags = 6
        static var titleOfCategory = "Categories"
        static var titleOfArea = "Area"
        static var titleOfIngredient = "Ingredients"
        static var titleOfAllRecipes = "All recipes"
        static var searchBarPlaceholder = "Search"
        static var buttonTitleOfCategories = "All categories"
        static var buttonTitleOfAreas = "All areas"
        static var buttonTitleOfIngredients = "All ingredients"
    }

    // - MARK: -
    let apiManager = ApiManager()
    private var categoriesTag: [CategoryTag] = []
    private var areasTag: [AreaTag] = []
    private var ingredietsTag: [IngredientTag] = []
    private var recipe: [Recipe] = []
    private var recipes: Recipe?
    private var searchController: UISearchController?

    // - MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectinView()
        getApi()
        configureSearchController()
        configureNavigationBar()
    }
    // - MARK: Network
    private func getApi() {
        apiManager.getTagsOfCategories { [weak self] result in
            switch result {
            case .success(let categoriesTagsList):
                DispatchQueue.main.async {
                    self?.categoriesTag = categoriesTagsList.meals
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        apiManager.getTagsOfArea { [weak self] result in
            switch result {
            case .success(let areasTagsList):
                DispatchQueue.main.async {
                    self?.areasTag = areasTagsList.meals
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        apiManager.getTagsOfIngredients { [weak self] result in
            switch result {
            case .success(let ingredientsTagsList):
                DispatchQueue.main.async {
                    self?.ingredietsTag = ingredientsTagsList.meals
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        apiManager.getAllRecipes(search: "") { [weak self] result in
            switch result {
            case .success(let recipes):
                DispatchQueue.main.async {
                    self?.recipe = recipes.meals
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        apiManager.getRecipe { [weak self] result in
            switch result {
            case .success(let recipes):
                DispatchQueue.main.async {
                    self?.recipes = recipes.meals.first
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // - MARK: Configure
    private func configureSearchController() {
        let searchResults = AllRecipesTableViewController()
        searchController = UISearchController(searchResultsController: searchResults)
        searchController?.searchResultsUpdater = searchResults
        navigationItem.searchController = searchController
        searchController?.searchBar.placeholder = Spec.searchBarPlaceholder
    }
    
    private func configureCollectinView() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: "TagCollectionViewCell")
        collectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: "RecipeCollectionViewCell")
        collectionView.register(SearchHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchHeaderView")
    }
    // - MARK: UICollectionViewDataSource, UICollectionViewDelegate
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .category:
            return min(categoriesTag.count, Spec.countOfTags)
        case .area:
            return min(areasTag.count, Spec.countOfTags)
        case .ingredient:
            return min(ingredietsTag.count, Spec.countOfTags)
        case .allRecipes:
            return recipe.count
        default:
            fatalError()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section(rawValue: indexPath.section) {
        case .category:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as! TagCollectionViewCell
            let item = categoriesTag[indexPath.row]
            cell.tagLabel.text = item.category
            cell.backgroundColor = TagsType.category.color
            return cell
        case .area:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as! TagCollectionViewCell
            let item = areasTag[indexPath.row]
            cell.tagLabel.text = item.area
            cell.backgroundColor = TagsType.area.color
            return cell
        case .ingredient:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as! TagCollectionViewCell
            let item = ingredietsTag[indexPath.row]
            cell.tagLabel.text = item.ingredient
            cell.backgroundColor = TagsType.ingredient.color
            return cell
        case .allRecipes:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCollectionViewCell", for: indexPath) as! RecipeCollectionViewCell
            let item = recipe[indexPath.row]
            cell.recipeView.nameOfRecipeLabel.text = item.name
            cell.recipeView.categoryTagLabel.text = item.category
            cell.recipeView.areaTagLabel.text = item.area
            let url = URL(string: item.thumb ?? "")
            cell.recipeView.recipeImageView.kf.setImage(with: url)
            cell.recipeView.configure(item: item)
            return cell
        default:
            fatalError()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SearchHeaderView", for: indexPath) as! SearchHeaderView
        switch Section(rawValue: indexPath.section) {
        case .category:
            header.configure(title: Spec.titleOfCategory, actionTitle: Spec.buttonTitleOfCategories) { [weak self] in
                self?.showAllTags(.category)
            }
        case .area:
            header.configure(title: Spec.titleOfArea, actionTitle: Spec.buttonTitleOfAreas) { [weak self] in
                self?.showAllTags(.area)
            }
        case .ingredient:
            header.configure(title: Spec.titleOfIngredient, actionTitle: Spec.buttonTitleOfIngredients) { [weak self] in
                self?.showAllTags(.ingredient)
            }
        case .allRecipes:
            header.configure(title: Spec.titleOfAllRecipes, offset: 16)
        default:
            break
        }
        return header
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch Section(rawValue: indexPath.section) {
        case .category:
            showRecipes(.category, categoriesTag[indexPath.item].category)
        case .area:
            showRecipes(.area, areasTag[indexPath.item].area)
        case .ingredient:
            showRecipes(.ingredient, ingredietsTag[indexPath.item].ingredient)
        case  .allRecipes:
            let item = recipe[indexPath.row]
            showRecipe(item)
        default:
            break
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: Spec.collectionViewLayoutHeight)
    }

    func showAllTags(_ tag: TagsType) {
        let allTagsVC = AllTagsCollectionViewController()
        allTagsVC.tagsType = tag
        show(allTagsVC, sender: self)
    }

    private func configureNavigationBar() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "icon.left")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "icon.left")
        navigationController?.navigationBar.tintColor = UIColor(named: "black")
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}
