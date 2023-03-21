import UIKit

class GreetingTableViewCell: UITableViewCell {
    // - MARK: -Constants
    struct Spec {
        static let greetingLabel = "Hello, guest!"
        static let profileImage = UIImage(named: "profile")
    }
    // - MARK: -
    private let containerView: UIView = {
         let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints()
         return view
     }()

     private let greetingLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints()
         label.text = Spec.greetingLabel
         label.textColor = .specialBlack
         label.font = .montserratSemibBold24()
         return label
     }()

     private let profileImage: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints()
         imageView.image = Spec.profileImage
         imageView.contentMode = .scaleAspectFill
         imageView.setMasksToBounds()
         imageView.setCornerRadius()
         return imageView
     }()

    // - MARK: -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
extension GreetingTableViewCell {
    private func setupLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(greetingLabel)
        containerView.addSubview(profileImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            greetingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            greetingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            profileImage.centerYAnchor.constraint(equalTo: greetingLabel.centerYAnchor),
            profileImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            profileImage.heightAnchor.constraint(equalToConstant: 42),
            profileImage.widthAnchor.constraint(equalToConstant: 42)
        ])
    }
}
