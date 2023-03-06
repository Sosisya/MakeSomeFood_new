import UIKit

class RecipeCardView: UIView {
    
    private let shadowView: UIView = {
        let shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.masksToBounds = false
        shadowView.backgroundColor = UIColor(named: "white")
        shadowView.layer.shadowColor = UIColor(named: "black")!.cgColor
        shadowView.layer.shadowOpacity = 0.5 // 0.06
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 12)
        return shadowView
    }()

    private let conteinerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .red
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 12
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "recipe")
        return imageView
    }()

    private let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = UIColor(named: "white")
        button.backgroundColor = UIColor(named: "orange")
        button.layer.cornerRadius = 21
        return button
    }()

    private let nameOfRecipeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name of recipe"
        label.font = UIFont(name: "Montserrat-Medium", size: 16)
        label.tintColor = UIColor(named: "black")
        return label
    }()

    private let tagsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

    private let categoryTagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "category"
        label.font = UIFont(name: "Montserrat-Medium", size: 13)
        label.textColor = UIColor(named: "green")
        return label
    }()

    private let areaTagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "area"
        label.font = UIFont(name: "Montserrat-Medium", size: 13)
        label.textColor = UIColor(named: "orange")
        return label
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

extension RecipeCardView {
    private func setupLayout() {
        addSubview(shadowView)
        shadowView.addSubview(conteinerView)
        conteinerView.addSubview(recipeImageView)
        conteinerView.addSubview(likeButton)
        conteinerView.addSubview(nameOfRecipeLabel)
        tagsStackView.addArrangedSubview(categoryTagLabel)
        tagsStackView.addArrangedSubview(areaTagLabel)
        conteinerView.addSubview(tagsStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),

            conteinerView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            conteinerView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),

            recipeImageView.topAnchor.constraint(equalTo: conteinerView.topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor),
            recipeImageView.heightAnchor.constraint(equalToConstant: 230),

            likeButton.topAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: 8),
            likeButton.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -8),
            likeButton.heightAnchor.constraint(equalToConstant: 44),
            likeButton.widthAnchor.constraint(equalToConstant: 44),

            nameOfRecipeLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 8),
            nameOfRecipeLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor,constant: 16),
            nameOfRecipeLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -16),

            tagsStackView.topAnchor.constraint(equalTo: nameOfRecipeLabel.bottomAnchor, constant: 6),
            tagsStackView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 16),
            tagsStackView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -16),
            tagsStackView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -12)
        ])
    }
}
