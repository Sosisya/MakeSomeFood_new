import UIKit

class CategorieView: UIView {

    private var categorieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "recipe")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "black")
        view.alpha = 0.4
        return view
    }()

    private var categorieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Category"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        label.tintColor = UIColor(named: "white")
        return label

    }()

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setupLayout() {
        self.addSubview(categorieImageView)
        categorieImageView.addSubview(shadowView)
        categorieImageView.addSubview(categorieLabel)
    }
}

extension CategorieView {
    func setupConstraint() {
        NSLayoutConstraint.activate([
            categorieImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            categorieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            categorieImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            categorieImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
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
