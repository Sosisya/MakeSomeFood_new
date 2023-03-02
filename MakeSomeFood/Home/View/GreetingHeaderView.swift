import UIKit

class GreetingHeaderView: UITableViewHeaderFooterView {
   private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello, guest!"
        label.textColor = UIColor(named: "black")
        label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        return label
    }()

    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "profile")
        return imageView
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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

extension GreetingHeaderView {
    private func setupLayout() {
        addSubview(containerView)
        containerView.addSubview(greetingLabel)
        containerView.addSubview(profileImage)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),

            greetingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            greetingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            profileImage.centerYAnchor.constraint(equalTo: greetingLabel.centerYAnchor),
            profileImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            profileImage.heightAnchor.constraint(equalToConstant: 42),
            profileImage.widthAnchor.constraint(equalToConstant: 42)
        ])
    }
}
