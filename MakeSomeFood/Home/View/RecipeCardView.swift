import UIKit

class RecipeCardView: UIView {

    var hasLargeImage: Bool = true {
        didSet {
            let height: CGFloat = hasLargeImage ? 230 : 160
            recipeImageHeight?.constant = height
        }
    }

    private var recipeImageHeight: NSLayoutConstraint?
    
    private let shadowView: UIView = {
        let shadowView = UIView()
        shadowView.translates()
        shadowView.masked(false)
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowColor = UIColor(named: "black")!.cgColor
        shadowView.layer.shadowOpacity = 0.06
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 12)
        return shadowView
    }()

    private let conteinerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor(named: "white")
        containerView.masked(true)
        containerView.rounded()
        containerView.translates()
        return containerView
    }()

    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translates()
        imageView.contentMode = .scaleAspectFill
        imageView.masked(true)
        imageView.image = UIImage(named: "recipe")
        return imageView
    }()

    private let likeButton: UIButton = {
        let button = UIButton()
        button.translates()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = UIColor(named: "white")
        button.backgroundColor = UIColor(named: "orange")
        button.rounded(radius: 21)
        return button
    }()

    private let nameOfRecipeLabel: UILabel = {
        let label = UILabel()
        label.translates()
        label.text = "Name of recipe"
        label.font = UIFont(name: "Montserrat-Medium", size: 16)
        label.tintColor = UIColor(named: "black")
        return label
    }()

    private let tagsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translates()
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
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
        label.rounded()
        label.text = "area"
        label.font = .montserratMedium13()
        label.textColor = .specialOrange
        label.rounded()
        label.bordered()
        label.colored(color: label.textColor)
        label.masked(true)
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
        recipeImageHeight = recipeImageView.heightAnchor.constraint(equalToConstant: hasLargeImage ? 230 : 160)

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
            recipeImageHeight!,

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
