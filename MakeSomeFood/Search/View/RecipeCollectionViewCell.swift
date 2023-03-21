import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {

    let recipeView: RecipeCardView = {
        let view = RecipeCardView()
        view.translates()
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupLayout()
        setupConstraints()
    }
}

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

    override func prepareForReuse() {
        super.prepareForReuse()
        recipeView.recipeImageView.kf.cancelDownloadTask()
        recipeView.recipeImageView.image = nil
    }
}
