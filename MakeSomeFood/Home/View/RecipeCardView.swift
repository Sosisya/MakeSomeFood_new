import UIKit

class RecipeCardView: UIView {
// - MARK: Constants
    struct Spec {
        static let recipeImageHeightMax: CGFloat = 230
        static let recipeImageHeightMin: CGFloat = 160
        static let shadowViewOpacity: Float = 0.06
        static let shadowViewRadius: CGFloat = 10
        static let shadowViewOffset: CGSize = CGSize(width: 0, height: 12)
        static let likeButtonImage = UIImage(
            systemName: "heart",
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )
        static let nameOfRecipeLabelText = "Name of recipe"
        static let recipeImageView = UIImage(named: "recipe")
        static let stackViewSpacing: CGFloat = 8
        static let categoryTagLabelText = "Category"
        static let areaTagLabelText = "Area"
        static let nameOfRecipeAndTagsStackViewSpasing: CGFloat = 8
        static var likeButtonIconName = "heart"
        static var likeSelectedButtonIconName = "heart.fill"
    }

    var recipe: Recipe?
    private var isFavourite = false


    // - MARK: -
    private let shadowView: UIView = {
        let shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints()
        shadowView.setMasksToBounds(false)
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
        containerView.setMasksToBounds()
        containerView.setCornerRadius()
        containerView.translatesAutoresizingMaskIntoConstraints()
        return containerView
    }()

    let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints()
        imageView.contentMode = .scaleAspectFill
        imageView.setMasksToBounds()
        imageView.image = Spec.recipeImageView
        return imageView
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints()
        button.setImage(Spec.likeButtonImage, for: .normal)
        button.tintColor = .specialWhite
        button.backgroundColor = .specialOrange
        button.setCornerRadius(radius: 22)
        button.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
        return button
    }()

    let nameOfRecipeAndTagsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints()
        stackView.axis = .vertical
        stackView.spacing = Spec.nameOfRecipeAndTagsStackViewSpasing
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()

    let nameOfRecipeLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints()
        label.text = Spec.nameOfRecipeLabelText
        label.font = .montserratMedium16()
        label.tintColor = .specialBlack
        label.numberOfLines = 0
        return label
    }()

    let tagsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints()
        stackView.spacing = Spec.stackViewSpacing
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        return stackView
    }()

    let categoryTagLabel: LabelWithInsets = {
        let label = LabelWithInsets()
        label.translatesAutoresizingMaskIntoConstraints()
        label.text = Spec.categoryTagLabelText
        label.font = .montserratMedium13()
        label.textColor = .specialGreen
        label.setCornerRadius()
        label.setBorderWidth()
        label.setColor(color: label.textColor)
        label.setNumberOfLines()
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
        label.setNumberOfLines()
        return label
    }()

    var hasLargeImage: Bool = true {
        didSet {
            let height: CGFloat = hasLargeImage ? Spec.recipeImageHeightMax : Spec.recipeImageHeightMin
            recipeImageHeight?.constant = height
        }
    }

    private var recipeImageHeight: NSLayoutConstraint?

// - MARK: -
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

// - MARK: -
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

    func setIsFavourite(_ value: Bool) {
        isFavourite = value
        let imageName = value ? Spec.likeSelectedButtonIconName : Spec.likeButtonIconName
        let image = UIImage(
            systemName: imageName,
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )
        likeButton.setImage(image, for: .normal)
    }

    // - MARK: Configure
    func configure(item: Recipe) {
        recipe = item
        nameOfRecipeLabel.text = item.name
        recipeImageView.kf.setImage(with: URL(string: item.thumb ?? ""))
        categoryTagLabel.text = item.category
        areaTagLabel.text = item.area
//        configureIsFavourite(recipeId: item.id)
    }

    func configure(item: RecipeOfCategory) {
        recipe = .init(recipeOfCategory: item)
        nameOfRecipeLabel.text = item.name
        recipeImageView.kf.setImage(with: URL(string: item.thumb))
//        tagsStackView.isHidden = true
//        configureIsFavourite(recipeId: item.id)
    }

    @objc func likeButtonAction() {
        toggleFavourites()
    }

    func toggleFavourites() {
        if isFavourite {
            print("delete")
        } else {
            guard let recipe = recipe else { return }
            FavouritesManager.addFavourite(recipe)
        }
    }

}
