import UIKit

class NameOfRecipeTableViewCell: UITableViewCell {
    struct Spec {
        static let nameOfRecipeLabelText = "Name of recipe"
        static let categoryTagLabelText = "Category"
        static let areaTagLabelText = "Area"
        static let numberOfNameOfRecipeLabelLines = 0
        static let numberOfCategoryTagLabelLines = 0
        static let numberOfAreaTagLabelLines = 0
    }

    let nameOfRecipeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints()
        label.textColor = .specialBlack
        label.text = Spec.nameOfRecipeLabelText
        label.font = .montserratSemibBold24()
        label.numberOfLines = Spec.numberOfNameOfRecipeLabelLines
        return label
    }()

    let categoryTagLabel: LabelWithInsets = {
        let label = LabelWithInsets()
        label.translatesAutoresizingMaskIntoConstraints()
        label.setCornerRadius()
        label.text = Spec.categoryTagLabelText
        label.font = .montserratMedium13()
        label.textColor = .specialGreen
        label.setCornerRadius()
        label.setBorderWidth()
        label.setColor(color: label.textColor)
        label.setMasksToBounds()
        label.numberOfLines = Spec.numberOfCategoryTagLabelLines
        label.textAlignment = .center
        return label
    }()

    let areaTagLabel: LabelWithInsets = {
        let label = LabelWithInsets()
        label.translatesAutoresizingMaskIntoConstraints()
        label.setCornerRadius()
        label.text = Spec.areaTagLabelText
        label.font = .montserratMedium13()
        label.textColor = .specialOrange
        label.setCornerRadius()
        label.setBorderWidth()
        label.setColor(color: label.textColor)
        label.setMasksToBounds()
        label.numberOfLines = Spec.numberOfAreaTagLabelLines
        label.textAlignment = .center
        return label
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

extension NameOfRecipeTableViewCell {
    private func setupLayout() {
        contentView.addSubview(nameOfRecipeLabel)
        contentView.addSubview(categoryTagLabel)
        contentView.addSubview(areaTagLabel)
    }

    private func setupConstraits() {
        NSLayoutConstraint.activate([
            nameOfRecipeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameOfRecipeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameOfRecipeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            categoryTagLabel.topAnchor.constraint(equalTo: nameOfRecipeLabel.bottomAnchor, constant: 8),
            categoryTagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categoryTagLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            areaTagLabel.centerYAnchor.constraint(equalTo: categoryTagLabel.centerYAnchor),
            areaTagLabel.leadingAnchor.constraint(equalTo: categoryTagLabel.trailingAnchor, constant: 6),
            areaTagLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
