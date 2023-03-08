import UIKit

class CategorieTableViewCell: UITableViewCell {
    
    struct Spec {
        static let shadowViewAlpha = 0.36
        static let categorieImageView = UIImage(named: "recipe")
        static let categoryLabelText = "Category"
    }

    private let categorieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translates()
        imageView.masked(true)
        imageView.rounded()
        imageView.image = Spec.categorieImageView
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let shadowView: UIView = {
        let view = UIView()
        view.translates()
        view.rounded()
        view.backgroundColor = .specialBlack
        view.alpha = Spec.shadowViewAlpha
        return view
    }()

    private let categorieLabel: UILabel = {
        let label = UILabel()
        label.translates()
        label.text = Spec.categoryLabelText
        label.font = .montserratSemibBold24()
        label.textColor = .specialWhite
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
        setupConstraints()
    }
}

extension CategorieTableViewCell {
    private func setupLayout() {
        contentView.addSubview(categorieImageView)
        categorieImageView.addSubview(shadowView)
        categorieImageView.addSubview(categorieLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categorieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            categorieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categorieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            categorieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            categorieImageView.heightAnchor.constraint(equalToConstant: 88),

            shadowView.topAnchor.constraint(equalTo: categorieImageView.topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: categorieImageView.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: categorieImageView.trailingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: categorieImageView.bottomAnchor),

            categorieLabel.centerYAnchor.constraint(equalTo: categorieImageView.centerYAnchor),
            categorieLabel.leadingAnchor.constraint(equalTo: categorieImageView.leadingAnchor, constant: 16),
            categorieLabel.trailingAnchor.constraint(equalTo: categorieImageView.trailingAnchor, constant: -16),
        ])
    }
}
