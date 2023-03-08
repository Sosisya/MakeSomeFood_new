import UIKit

class IngredientsTableViewCell: UITableViewCell {
    struct Spec {
        static let ingredientLabelText = "Ingredient"
        static let quantityOfIngredientsLabelText = "Quantity"
        static let numberOfingredientLabelLines = 0
        static let numberOfquantityOfIngredientsLabelLines = 0
    }

    private let ingredientLabel: UILabel = {
        let label = UILabel()
        label.translates()
        label.text = Spec.ingredientLabelText
        label.font = .montserratRegular13()
        label.textColor = .specialBlack
        label.textAlignment = .left
        label.numberOfLines = Spec.numberOfquantityOfIngredientsLabelLines
        return label
    }()

    private let quantityOfIngredientsLabel: UILabel = {
        let label = UILabel()
        label.translates()
        label.text = Spec.quantityOfIngredientsLabelText
        label.font = .montserratRegular13()
        label.textColor = .specialBlack
        label.textAlignment = .right
        label.numberOfLines = Spec.numberOfquantityOfIngredientsLabelLines
        return label
    }()

    private let bottomLineView: UIView = {
        let view = UIView()
        view.translates()
        view.backgroundColor = .specialGrayFill
        return view
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
}

extension IngredientsTableViewCell {
    private func setupLayout() {
        contentView.addSubview(ingredientLabel)
        contentView.addSubview(quantityOfIngredientsLabel)
        contentView.addSubview(bottomLineView)
    }

    private func setupConstraits() {
        NSLayoutConstraint.activate([
            ingredientLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            ingredientLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ingredientLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ingredientLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            quantityOfIngredientsLabel.centerYAnchor.constraint(equalTo: ingredientLabel.centerYAnchor),
            quantityOfIngredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            bottomLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bottomLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bottomLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomLineView.heightAnchor.constraint(equalToConstant: 1.5)
        ])
    }
}
