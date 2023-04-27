import UIKit
import FirebaseAuth
import Kingfisher
import FirebaseStorage

class HomeTableHeaderView: UIView {
    // - MARK: -
    struct Spec {
        static let greetingLabel = "Hello, %@!"
        static let profileImageView = UIImage(named: "profile")
    }

    var handle: AuthStateDidChangeListenerHandle?
    // - MARK: -
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints()
        label.textColor = .specialBlack
        label.font = .montserratSemibBold24()
        return label
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints()
        imageView.image = Spec.profileImageView
        imageView.contentMode = .scaleAspectFill
        imageView.setMasksToBounds()
        imageView.setCornerRadius()
        return imageView
    }()

    private let storage = Storage.storage()

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

    func refreshUser(_ user: User?) {
        let name = user?.displayName ?? "guest"
        greetingLabel.text = String(format: Spec.greetingLabel, name)
        downloadImage()
    }

    private func downloadImage() {
        let storageRef = storage.reference()
        let id = Auth.auth().currentUser?.uid ?? "invalid"
        let avatarRef = storageRef.child("images/\(id).jpg")
        avatarRef.downloadURL { [weak self] url, error in
            DispatchQueue.main.async {
                guard let downloadURL = url else {
                    self?.profileImageView.image = UIImage(named: "profile")
                    return
                }
                self?.profileImageView.kf.setImage(with: downloadURL)
            }
        }
    }
}

// - MARK: -
extension HomeTableHeaderView {
    private func setupLayout() {
        addSubview(greetingLabel)
        addSubview(profileImageView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            greetingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            greetingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

            profileImageView.centerYAnchor.constraint(equalTo: greetingLabel.centerYAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            profileImageView.heightAnchor.constraint(equalToConstant: 42),
            profileImageView.widthAnchor.constraint(equalToConstant: 42)
        ])
    }
}
