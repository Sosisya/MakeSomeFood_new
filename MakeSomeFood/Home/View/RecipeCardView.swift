import UIKit
//Есть вопросы
//likeButton радиус?

class RecipeCardView: UIView {

    struct Spec {
        static let recipeImageHeightMax: CGFloat = 230
        static let recipeImageHeightMin: CGFloat = 160
        static let shadowViewOpacity: Float = 0.06
        static let shadowViewRadius: CGFloat = 10
        static let shadowViewOffset: CGSize = CGSize(width: 0, height: 12)
        static let likeButtonImage = UIImage(systemName: "heart")
        static let nameOfRecipeLabelText = "Name of recipe"
        static let recipeImageView = UIImage(named: "recipe")
        static let stackViewSpacing: CGFloat = 8
        static let categoryTagLabelText = "Category"
        static let areaTagLabelText = "Area"
        static let nameOfRecipeAndTagsStackViewSpasing: CGFloat = 8
    }

    var hasLargeImage: Bool = true {
        didSet {
            let height: CGFloat = hasLargeImage ? Spec.recipeImageHeightMax : Spec.recipeImageHeightMin
            recipeImageHeight?.constant = height
        }
    }

    private var recipeImageHeight: NSLayoutConstraint?
    
    private let shadowView: UIView = {
        let shadowView = UIView()
        shadowView.translates()
        shadowView.masked(false)
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowColor = UIColor.specialBlack.cgColor
        shadowView.layer.shadowOpacity = Spec.shadowViewOpacity
        shadowView.layer.shadowRadius = Spec.shadowViewRadius
        shadowView.layer.shadowOffset = Spec.shadowViewOffset
        return shadowView
    }()

    private let conteinerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .specialWhite
        containerView.masked(true)
        containerView.rounded()
        containerView.translates()
        return containerView
    }()

    let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translates()
        imageView.contentMode = .scaleAspectFill
        imageView.masked(true)
        imageView.image = Spec.recipeImageView
        return imageView
    }()

    private let likeButton: UIButton = {
        let button = UIButton()
        button.translates()
        button.setImage(Spec.likeButtonImage, for: .normal)
        button.tintColor = .specialWhite
        button.backgroundColor = .specialOrange
        button.rounded(radius: 21) // как установить исходя из собственной высоты??
        return button
    }()

    let nameOfRecipeAndTagsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translates()
        stackView.axis = .vertical
        stackView.spacing = Spec.nameOfRecipeAndTagsStackViewSpasing
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

    let nameOfRecipeLabel: UILabel = {
        let label = UILabel()
        label.translates()
        label.text = Spec.nameOfRecipeLabelText
        label.font = .montserratMedium16()
        label.tintColor = .specialBlack
        return label
    }()

    let tagsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translates()
        stackView.spacing = Spec.stackViewSpacing
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

    let categoryTagLabel: LabelWithInsets = {
        let label = LabelWithInsets()
        label.translates()
        label.text = Spec.categoryTagLabelText
        label.font = .montserratMedium13()
        label.textColor = .specialGreen
        label.rounded()
        label.bordered()
        label.colored(color: label.textColor)
        return label
    }()

    let areaTagLabel: LabelWithInsets = {
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
        nameOfRecipeAndTagsStackView.addArrangedSubview(nameOfRecipeLabel)
        tagsStackView.addArrangedSubview(categoryTagLabel)
        tagsStackView.addArrangedSubview(areaTagLabel)
        nameOfRecipeAndTagsStackView.addArrangedSubview(tagsStackView)
        conteinerView.addSubview(nameOfRecipeAndTagsStackView)
    }

    private func setupConstraints() {
        recipeImageHeight = recipeImageView.heightAnchor.constraint(equalToConstant: hasLargeImage ? Spec.recipeImageHeightMax : Spec.recipeImageHeightMin)

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

            nameOfRecipeAndTagsStackView.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 6),
            nameOfRecipeAndTagsStackView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 16),
            nameOfRecipeAndTagsStackView.trailingAnchor.constraint(lessThanOrEqualTo: conteinerView.trailingAnchor, constant: -16),
            nameOfRecipeAndTagsStackView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: -12)
        ])
    }
}
