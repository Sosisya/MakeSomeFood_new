import UIKit

class RecipeCardView: UIView {

    private let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(named: "white")
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = false
        containerView.layer.shadowOffset = CGSize(width: -1, height: 1)
        containerView.layer.shadowRadius = 1
        containerView.layer.shadowOpacity = 0.5
        return containerView
    }()

    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
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

//    var hasLargeImage: Bool = false {
//        didSet {
//            let height: CGFloat = hasLargeImage ? Spec.maxHeighOfImage : Spec.minHeighOfImage
//            coverImageHeight.constant = height
//        }
//    }

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
    func setupLayout() {
        addSubview(containerView)
        containerView.addSubview(recipeImageView)
        containerView.addSubview(likeButton)
        containerView.addSubview(nameOfRecipeLabel)
        tagsStackView.addArrangedSubview(categoryTagLabel)
        tagsStackView.addArrangedSubview(areaTagLabel)
        containerView.addSubview(tagsStackView)
        clipsToBounds = true
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),

            recipeImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            recipeImageView.heightAnchor.constraint(equalToConstant: 230),

            likeButton.topAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: 8),
            likeButton.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -8),
            likeButton.heightAnchor.constraint(equalToConstant: 44),
            likeButton.widthAnchor.constraint(equalToConstant: 44),

            nameOfRecipeLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 8),
            nameOfRecipeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 16),
            nameOfRecipeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            tagsStackView.topAnchor.constraint(equalTo: nameOfRecipeLabel.bottomAnchor, constant: 6),
            tagsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            tagsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            tagsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
    }
}
