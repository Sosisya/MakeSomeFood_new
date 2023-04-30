import UIKit
import FirebaseDatabase
import FirebaseAuth

class CookingHeaderView: UIView {
    struct Spec {
        static let alphaOfShadowView = 0.3
        static let likeButtonImage = UIImage(
            systemName: "heart",
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )
        static let recipeImageView = UIImage(named: "recipe")
        static var headerBottomViewCornerRadius: CGFloat = 10
        static var headerFavouriteButtonCornerRadius: CGFloat = 22
        static var likeButtonIconName = "heart"
        static var likeSelectedButtonIconName = "heart.fill"
    }

    var recipe: Recipe?
    private var isFavourite = false
    private var isFavouriteRef: DatabaseReference?
    private var isFavouriteHandle: UInt?
    var authHandle: AuthStateDidChangeListenerHandle?
    var userId: String?

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints()
        return view
    }()

    let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints()
        imageView.image = Spec.recipeImageView
        imageView.contentMode = .scaleAspectFill
        imageView.setMasksToBounds()
        return imageView
    }()

    private let shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints()
        view.backgroundColor = .specialBlack
        view.alpha = Spec.alphaOfShadowView
        return view
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints()
        button.setImage(Spec.likeButtonImage, for: .normal)
        button.tintColor = .specialWhite
        button.backgroundColor = .specialOrange
        button.setCornerRadius(radius: 21)
        button.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
        return button
    }()

    private let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints()
        view.backgroundColor = .specialWhite
        view.setCornerRadius()
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()

    var containerViewHeight = NSLayoutConstraint()
    var imageViewHeight = NSLayoutConstraint()
    var imageViewBottom = NSLayoutConstraint()

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
        backgroundColor = .specialWhite
        addSubview(containerView)
        containerView.addSubview(recipeImageView)
        recipeImageView.addSubview(shadowView)
        recipeImageView.addSubview(bottomView)
        recipeImageView.addSubview(likeButton)
    }

    private func setupConstraints() {
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: heightAnchor)
        imageViewBottom = recipeImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageViewHeight = recipeImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)

        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: recipeImageView.widthAnchor),
            containerViewHeight,
            imageViewBottom,
            imageViewHeight,
            
            recipeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            shadowView.topAnchor.constraint(equalTo: recipeImageView.topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: recipeImageView.bottomAnchor),

            bottomView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 26),

            likeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            likeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
            likeButton.heightAnchor.constraint(equalToConstant: 44),
            likeButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
// - MARK: Favourite
extension CookingHeaderView {
    func setIsFavourite(_ value: Bool) {
        isFavourite = value
        let imageName = value ? Spec.likeSelectedButtonIconName : Spec.likeButtonIconName
        let image = UIImage(
            systemName: imageName,
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )
        likeButton.setImage(image, for: .normal)
    }

    func configure(item: Recipe) {
        recipe = item
        recipeImageView.kf.setImage(with: URL(string: item.thumb ?? ""))
        configureIsFavourite(recipeId: item.id)
    }

    func cancelFavouriteSubscription() {
        guard let isFavouriteRef, let isFavouriteHandle else { return }
        FavouritesManager.cancelFavouriteSubscription(isFavouriteRef, isFavouriteHandle)
    }

    @objc func likeButtonAction() {
        toggleFavourites()
        print("HEADER")
    }

    func toggleFavourites() {
        if isFavourite {
            FavouritesManager.removeFavourites(recipeId: recipe!.id)
        } else {
            FavouritesManager.addFavourite(recipe!)
        }
    }

    private func configureIsFavourite(recipeId: String) {
        userId = Auth.auth().currentUser?.uid
        authHandle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self else { return }
            if user == nil || user?.uid != self.userId,
               let isFavouriteRef = self.isFavouriteRef,
               let isFavouriteHandle = self.isFavouriteHandle {
                self.setIsFavourite(false)
                FavouritesManager.cancelFavouriteSubscription(isFavouriteRef, isFavouriteHandle)
            }
            if user != nil {
                (self.isFavouriteRef, self.isFavouriteHandle) = FavouritesManager.isFavourite(recipeId: recipeId) { [weak self] isFavourite in
                    self?.setIsFavourite(isFavourite)
                }
            }
            self.userId = user?.uid
        }
    }
}
