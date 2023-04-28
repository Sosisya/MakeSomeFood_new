import UIKit
import FirebaseAuth

class RecipeCollectionViewCell: UICollectionViewCell {
    // - MARK: -
    let recipeView: RecipeCardView = {
        let view = RecipeCardView()
        view.translatesAutoresizingMaskIntoConstraints()
        return view
    }()
    // - MARK: -
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recipeView.recipeImageView.kf.cancelDownloadTask()
        recipeView.recipeImageView.image = nil
        recipeView.cancelFavouriteSubscription()
        if let authHandle = recipeView.authHandle {
            Auth.auth().removeStateDidChangeListener(authHandle)
        }
    }

    private func commonInit() {
        setupLayout()
        setupConstraints()
    }
    
}
// - MARK: -
extension RecipeCollectionViewCell {
    private func setupLayout() {
        contentView.addSubview(recipeView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            recipeView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
