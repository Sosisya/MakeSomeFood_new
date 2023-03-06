import UIKit

class CookingHeaderView: UIView {

    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "recipe")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "black")
        view.alpha = 0.3
        return view
    }()

    private let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = UIColor(named: "white")
        button.backgroundColor = UIColor(named: "orange")
        button.layer.cornerRadius = 21
        return button
    }()

    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "white")
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
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

extension CookingHeaderView {
    private func setupLayout() {
        addSubview(recipeImageView)
        recipeImageView.addSubview(shadowView)
        shadowView.addSubview(likeButton)
        shadowView.addSubview(bottomView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipeImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            recipeImageView.heightAnchor.constraint(equalToConstant: 280),

            shadowView.topAnchor.constraint(equalTo: recipeImageView.topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: recipeImageView.bottomAnchor),

            bottomView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 26),

            likeButton.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -16),
            likeButton.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -4),
            likeButton.heightAnchor.constraint(equalToConstant: 44),
            likeButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
}
