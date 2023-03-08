import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    private var recipeView: RecipeCardView = {
        let recipeView = RecipeCardView()
        recipeView.translates()
        return recipeView
    }()

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

    func setHasLargeImage(_ hasLargeImage: Bool) {
        recipeView.hasLargeImage = hasLargeImage
        if hasLargeImage == false {
            recipeView.tagsStackView.isHidden = true
        }
    }
}

extension RecipeTableViewCell {
    private func setupLayout() {
        contentView.addSubview(recipeView)
    }

    private func setupConstraits() {
        NSLayoutConstraint.activate([
            recipeView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
