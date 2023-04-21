import UIKit
import FirebaseAuth
import Kingfisher

class HomeTableHeaderView: UIView {
    // - MARK: -
    struct Spec {
        static let greetingLabel = "Hello, %@!"
        static let profileImage = UIImage(named: "profile")
    }

    var handle: AuthStateDidChangeListenerHandle?
    // - MARK: -
     private let greetingLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints()
//         label.text = Spec.greetingLabel
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
         observeName()
     }

    private func observeName() {
        handle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            DispatchQueue.main.async {
                self?.refreshUser(user)
            }
        }
    }

    private func refreshUser(_ user: User?) {
        let photoURL = user?.photoURL
        let name = user?.displayName ?? "guest"
        greetingLabel.text = String(format: Spec.greetingLabel, name)
        profileImage.kf.setImage(with: photoURL, placeholder: Spec.profileImage)
    }
 }

// - MARK: -
extension HomeTableHeaderView {
    private func setupLayout() {
        addSubview(greetingLabel)
        addSubview(profileImage)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            greetingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            greetingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

            profileImage.centerYAnchor.constraint(equalTo: greetingLabel.centerYAnchor),
            profileImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            profileImage.heightAnchor.constraint(equalToConstant: 42),
            profileImage.widthAnchor.constraint(equalToConstant: 42)
        ])
    }
}
