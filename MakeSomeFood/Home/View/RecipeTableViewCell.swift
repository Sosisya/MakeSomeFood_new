import UIKit
import FirebaseAuth

class RecipeTableViewCell: UITableViewCell {
    // - MARK: -
    var recipeView: RecipeCardView = {
        let recipeView = RecipeCardView()
        recipeView.translatesAutoresizingMaskIntoConstraints()
        return recipeView
    }()

    // - MARK: -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupLayout()
        setupConstraits()
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
}

// - MARK: -
extension RecipeTableViewCell {
    private func setupLayout() {
        contentView.addSubview(recipeView)
    }

    private func setupConstraits() {
        NSLayoutConstraint.activate([
            recipeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            recipeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    func setHasLargeImage(_ hasLargeImage: Bool) {
        recipeView.hasLargeImage = hasLargeImage
    }

    func hideTags(_ hide: Bool) {
        recipeView.tagsStackView.isHidden = hide
    }
}
