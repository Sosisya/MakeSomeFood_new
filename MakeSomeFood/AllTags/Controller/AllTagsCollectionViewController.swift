import UIKit

class AllTagsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let apiManager = ApiManager()
    private var categoriesTag: [CategoryTag] = []
    private var areasTag: [AreaTag] = []
    private var ingredietsTag: [IngredientTag] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: "TagCollectionViewCell")
        getApi()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesTag.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as! TagCollectionViewCell
        let item = categoriesTag[indexPath.row].category
        cell.tagLabel.text = item
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 42)
    }
}

extension AllTagsCollectionViewController {
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
    }
}
