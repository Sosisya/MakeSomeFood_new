import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    struct Spec {
        static var takePhotoButtonFirstAlertTitle = "Take photo"
        static var takePhotoButtonSecondAlertTitle = "Open gallery"
        static var takePhotoButtonCancelAlertTitle = "Cancel"
    }
// -MARK: Constants
    private var scrollViewBottom: NSLayoutConstraint?

// -MARK: Properties
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
        button.setTitle("Save", for: .normal)
        button.setTitleColor(UIColor(named: "white"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        button.backgroundColor = UIColor(named: "orange")
        button.layer.cornerRadius = 12
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
        configurationNotificationCenter()
        configureButton()
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
       view.addSubview(exitButton)
    }

   private func setupConstraint() {
       scrollViewBottom = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollViewBottom!,

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

            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            exitButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    private func configurationNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
            scrollViewBottom?.constant = -(keyboardSize.height - tabBarHeight)
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        scrollViewBottom?.constant = 0
    }

    private func configureButton() {
        takePhotoButton.addTarget(self, action: #selector(takeAPhoto), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveInformation), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitFromAccount), for: .touchUpInside)
    }

    @objc private func takeAPhoto() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: Spec.takePhotoButtonFirstAlertTitle, style: .default , handler:{ (UIAlertAction) in
            self.openCameraButton()
            print("User click Take a photo button")
        }))

        alert.addAction(UIAlertAction(title: Spec.takePhotoButtonSecondAlertTitle, style: .default , handler:{ (UIAlertAction) in
            self.openPhotoLibraryButton()
            print("User click Open Gallery")
        }))

        alert.addAction(UIAlertAction(title: Spec.takePhotoButtonCancelAlertTitle, style: .cancel, handler:{ (UIAlertAction) in
            print("User click Dismiss button")
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }

    @objc private func saveInformation() {
        print("save")
    }

    @objc private func exitFromAccount() {
        print("exit")
    }

    private func openCameraButton() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    private func openPhotoLibraryButton() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}
