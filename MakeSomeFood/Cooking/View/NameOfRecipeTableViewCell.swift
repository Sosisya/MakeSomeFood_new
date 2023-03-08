import UIKit

class NameOfRecipeTableViewCell: UITableViewCell {

    private let nameOfRecipeLabel: UILabel = {
        let label = UILabel()
        label.translates()
        label.textColor = .specialBlack
        label.text = "Name of recipe"
        label.font = .montserratSemibBold24()
        return label
    }()

    private let categoryTagLabel: LabelWithInsets = {
        let label = LabelWithInsets()
        label.translates()
        label.text = "category"
        label.font = .montserratMedium13()
        label.textColor = .specialGreen
        label.rounded()
        label.bordered()
        label.colored(color: label.textColor)
        return label
    }()

    private let areaTagLabel: LabelWithInsets = {
        let label = LabelWithInsets()
        label.translates()
        label.layer.cornerRadius = 12
        label.text = "area"
        label.font = UIFont(name: "Montserrat-Medium", size: 13)
        label.textColor = UIColor(named: "orange")
        label.rounded()
        label.layer.borderWidth = 1
        label.layer.borderColor = label.textColor.cgColor
        label.layer.masksToBounds = true
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            nameOfRecipeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            categoryTagLabel.topAnchor.constraint(equalTo: nameOfRecipeLabel.bottomAnchor, constant: 8),
            categoryTagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categoryTagLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            categoryTagLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            areaTagLabel.centerYAnchor.constraint(equalTo: categoryTagLabel.centerYAnchor),
            areaTagLabel.leadingAnchor.constraint(greaterThanOrEqualTo: categoryTagLabel.leadingAnchor, constant: 6),
            areaTagLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
