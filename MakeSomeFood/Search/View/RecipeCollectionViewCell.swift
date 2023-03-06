import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {

    private let recipeView: RecipeCardView = {
        let view = RecipeCardView()
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
}
