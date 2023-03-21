import UIKit

class CookingHeaderView: UIView {
    
    struct Spec {
        static let alphaOfShadowView = 0.3
        static let likeButtonImage = UIImage(systemName: "heart")
        static let recipeImageView = UIImage(named: "recipe")
    }

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

    private let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints()
        button.setImage(Spec.likeButtonImage, for: .normal)
        button.tintColor = .specialWhite
        button.backgroundColor = .specialOrange
        button.setCornerRadius(radius: 21)
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
