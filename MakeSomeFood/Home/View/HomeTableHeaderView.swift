import UIKit

class HomeTableHeaderView: UITableViewHeaderFooterView {

    struct Spec {
        static let greetingLabel = "Hello, guest!"
        static let profileImage = UIImage(named: "profile")
    }
    
     private let greetingLabel: UILabel = {
         let label = UILabel()
         label.translates()
         label.text = Spec.greetingLabel
         label.textColor = .specialBlack
         label.font = .montserratSemibBold24()
         return label
     }()

     private let profileImage: UIImageView = {
         let imageView = UIImageView()
         imageView.translates()
         imageView.image = Spec.profileImage
         imageView.contentMode = .scaleAspectFill
         imageView.masked(true)
         imageView.rounded()
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

extension HomeTableHeaderView {
    private func setupLayout() {
        addSubview(greetingLabel)
        addSubview(profileImage)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            greetingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            greetingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

            profileImage.centerYAnchor.constraint(equalTo: greetingLabel.centerYAnchor),
            profileImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            profileImage.heightAnchor.constraint(equalToConstant: 42),
            profileImage.widthAnchor.constraint(equalToConstant: 42)
        ])
    }
}
