import UIKit

class AllTagsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, RecipePresenting {
    let apiManager = ApiManager()
    var tagsType: TagsType!
    private var tags: [String] = []

    init() {
        super.init(collectionViewLayout: SearchCompositionalLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: "TagCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        getApi()
        configureNavigationBar()
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as! TagCollectionViewCell
        let item = tags[indexPath.row]
        cell.tagLabel.text = item
        cell.backgroundColor = tagsType?.color
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 42)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showRecipes(tagsType, tags[indexPath.item])
    }
}

extension AllTagsCollectionViewController {
    private func getApi() {
        switch tagsType {
        case .category:
            apiManager.getTagsOfCategories { [weak self] result in
                switch result {
                case .success(let categoriesTagsList):
                    DispatchQueue.main.async {
                        self?.tags = categoriesTagsList.meals.map { $0.category }
                        self?.collectionView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case .area:
            apiManager.getTagsOfArea { [weak self] result in
                switch result {
                case .success(let areaTagsList):
                    DispatchQueue.main.async {
                        self?.tags = areaTagsList.meals.map { $0.area }
                        self?.collectionView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }

        case .ingredient:
            apiManager.getTagsOfIngredients { [weak self] result in
                switch result {
                case .success(let ingredientsTagsList):
                    DispatchQueue.main.async {
                        self?.tags = ingredientsTagsList.meals.map { $0.ingredient }
                        self?.collectionView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            break
        }
    }

    private func configureNavigationBar() {
        title = tagsType.title
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "icon.left")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "icon.left")
        navigationController?.navigationBar.tintColor = UIColor(named: "black")
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}
