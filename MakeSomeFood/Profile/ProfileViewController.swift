import UIKit

class ProfileViewController: UIViewController {
// -MARK:
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .blue
        return scrollView
    }()

    private let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .red
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.image = UIImage(named: "profile")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let takePhotoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.tintColor =  UIColor(named: "white")
        button.backgroundColor = UIColor(named: "orange")
        button.layer.cornerRadius = 21
        return button
    }()

    private let nameTextFieldView: TextFieldView = {
        let textfieldView = TextFieldView()
        textfieldView.translatesAutoresizingMaskIntoConstraints = false
        textfieldView.layer.cornerRadius = 12
        textfieldView.layer.borderColor = UIColor(named: "grayFill")?.cgColor
        textfieldView.layer.borderWidth = 1
        textfieldView.floatingLabel.text = "Name"
        return textfieldView
    }()

    private let emailTextFieldView: TextFieldView = {
        let textfieldView = TextFieldView()
        textfieldView.translatesAutoresizingMaskIntoConstraints = false
        textfieldView.layer.cornerRadius = 12
        textfieldView.layer.borderColor = UIColor(named: "grayFill")?.cgColor
        textfieldView.layer.borderWidth = 1
        textfieldView.floatingLabel.text = "E-mail"
        return textfieldView
    }()

    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(UIColor(named: "white"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        button.backgroundColor = UIColor(named: "orange")
        button.layer.cornerRadius = 12
        button.isHidden = true
        return button
    }()

    private let exitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log out", for: .normal)
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.forward"), for: .normal)
        button.setTitleColor(UIColor(named: "coral"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        button.backgroundColor = UIColor(named: "grayFill")
        button.tintColor =  UIColor(named: "coral")
        button.layer.cornerRadius = 12
        return button
    }()

    // -MARK:
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupConstraint()
    }
}

// -MARK: Extension
extension ProfileViewController {
   private func setupLayout() {
       view.addSubview(scrollView)
       scrollView.addSubview(contentView)
       contentView.addSubview(profileImageView)
       contentView.addSubview(takePhotoButton)
       contentView.addSubview(nameTextFieldView)
       contentView.addSubview(emailTextFieldView)
       contentView.addSubview(saveButton)
       contentView.addSubview(exitButton)
    }

   private func setupConstraint() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),

            takePhotoButton.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 64),
            takePhotoButton.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: 64),
            takePhotoButton.heightAnchor.constraint(equalToConstant: 44),
            takePhotoButton.widthAnchor.constraint(equalToConstant: 44),

            nameTextFieldView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 24),
            nameTextFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameTextFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameTextFieldView.heightAnchor.constraint(equalToConstant: 56),

            emailTextFieldView.topAnchor.constraint(equalTo: nameTextFieldView.bottomAnchor, constant: 16),
            emailTextFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            emailTextFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            emailTextFieldView.heightAnchor.constraint(equalToConstant: 56),

            saveButton.topAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 32),
            saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 56),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            exitButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            exitButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            exitButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            exitButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
