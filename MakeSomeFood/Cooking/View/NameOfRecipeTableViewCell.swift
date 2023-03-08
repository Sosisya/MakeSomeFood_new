import UIKit

class NameOfRecipeTableViewCell: UITableViewCell {
    struct Spec {
        static let nameOfRecipeLabelText = "Name of recipe"
        static let categoryTagLabelText = "Category"
        static let areaTagLabelText = "Area"
    }

    private let nameOfRecipeLabel: UILabel = {
        let label = UILabel()
        label.translates()
        label.textColor = .specialBlack
        label.text = Spec.nameOfRecipeLabelText
        label.font = .montserratSemibBold24()
        return label
    }()

    private let categoryTagLabel: LabelWithInsets = {
        let label = LabelWithInsets()
        label.translates()
        label.rounded()
        label.text = Spec.categoryTagLabelText
        label.font = .montserratMedium13()
        label.textColor = .specialGreen
        label.rounded()
        label.bordered()
        label.colored(color: label.textColor)
        label.masked(true)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let areaTagLabel: LabelWithInsets = {
        let label = LabelWithInsets()
        label.translates()
        label.rounded()
        label.text = Spec.areaTagLabelText
        label.font = .montserratMedium13()
        label.textColor = .specialOrange
        label.rounded()
        label.bordered()
        label.colored(color: label.textColor)
        label.masked(true)
        label.numberOfLines = 0
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
