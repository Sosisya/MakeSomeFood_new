import UIKit
import FirebaseAuth
import FirebaseStorage

class ProfileViewController: UIViewController, UINavigationControllerDelegate {
    struct Spec {
        static var takePhotoButtonFirstAlertTitle = "Take photo"
        static var takePhotoButtonSecondAlertTitle = "Open gallery"
        static var takePhotoButtonCancelAlertTitle = "Cancel"
        static var exitButtonMainAlertTitle = "Are you sure you want to log out of your profile?"
        static var exitButtonFirstAlertTitle = "Log out"
        static var exitButtonCancelAlertTitle = "Cancel"
    }

    struct ProfileData: Equatable {
        var changedPhoto: Bool
        var name: String
        var email: String
    }

    // -MARK: Constants
    private var scrollViewBottom: NSLayoutConstraint?
    private var saveButtonBottom: NSLayoutConstraint?
    private var saveButtonTop: NSLayoutConstraint?
    private let storage = Storage.storage()


    private var initialValues = {
        if let user = Auth.auth().currentUser {
            return ProfileData(changedPhoto: false, name: user.displayName ?? "", email: user.email ?? "")
        }
        return ProfileData(changedPhoto: false, name: "", email: "")
    }()

    private var currentValues: ProfileData {
        ProfileData(changedPhoto: false, name: nameTextFieldView.textField.text ?? "", email: emailTextFieldView.textField.text ?? "")
    }

    private var hasChanges: Bool {
        initialValues != currentValues
    }

    // -MARK: Properties
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let contentView = UIView()
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
        textfieldView.layer.borderWidth = 1
        textfieldView.floatingLabel.text = "Name"
        textfieldView.textField.autocapitalizationType = .words
        return textfieldView
    }()

    private let emailTextFieldView: TextFieldView = {
        let textfieldView = TextFieldView()
        textfieldView.translatesAutoresizingMaskIntoConstraints = false
        textfieldView.layer.cornerRadius = 12
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
        //        button.isHidden = true
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
        configureTapGesture()
        configureTextField()
        downloadImage()
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
            emailTextFieldView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            emailTextFieldView.heightAnchor.constraint(equalToConstant: 56),

            saveButton.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 56),
            saveButton.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor, constant: -16),

            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            exitButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
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
        saveButton.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
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

    @objc private func saveChanges() {
        saveButton.isEnabled = false
        if initialValues.name != currentValues.name {
            setDisplayName()
        }
    }

    private func setDisplayName() {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        let newName = currentValues.name
        changeRequest?.displayName = newName
        changeRequest?.commitChanges { [weak self] error in
            self?.initialValues.name = newName
            self?.saveButton.isEnabled = true
        }
    }

    private func reloadSaveButton() {
        saveButton.isHidden = !hasChanges
    }

    @objc private func exitFromAccount() {
        let alert = UIAlertController(title: Spec.exitButtonMainAlertTitle, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Spec.exitButtonFirstAlertTitle, style: .destructive , handler:{ (UIAlertAction) in
            do {
                try Auth.auth().signOut()
                self.onExit()
            } catch {
                print(error.localizedDescription)
            }
        }))

        alert.addAction(UIAlertAction(title: Spec.exitButtonCancelAlertTitle, style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
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

    private func configureTextField() {
        nameTextFieldView.setText(initialValues.name)
        emailTextFieldView.setText(initialValues.email)
    }

    private func onExit() {
        let vc = LoginViewController()
        let navVC = navigationController
        navVC?.viewControllers = [vc]
    }

    private func uploadImage(_ image: UIImage) {
        takePhotoButton.isHidden = true
        let data = image.jpegData(compressionQuality: 0.9) ?? Data()
        let storageRef = storage.reference()
        let id = Auth.auth().currentUser?.uid ?? "invalid"
        let avatarRef = storageRef.child("images/\(id).jpg")
        let uploadTask = avatarRef.putData(data, metadata: nil) { [weak self] metadata, error in
            DispatchQueue.main.async {
                self?.takePhotoButton.isHidden = false
            }
            guard let metadata = metadata else { return }
            let size = metadata.size
            avatarRef.downloadURL { url, error in
                guard let downloadURL = url else { return }
                print(downloadURL)
            }
        }
    }

    private func downloadImage() {
        profileImageView.image = nil
        takePhotoButton.isHidden = true
        let storageRef = storage.reference()
        let id = Auth.auth().currentUser?.uid ?? "invalid"
        let avatarRef = storageRef.child("images/\(id).jpg")
        avatarRef.downloadURL { [weak self] url, error in
            DispatchQueue.main.async {
                self?.takePhotoButton.isHidden = false
                guard let downloadURL = url else { return }
                self?.profileImageView.kf.setImage(with: downloadURL)
            }
        }
    }
}

//MARK: - UITextFieldDelegate
extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isHidden = false
    }
}

//MARK: - UIImagePickerControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.image = image
            uploadImage(image)
        }
        self.dismiss(animated: true, completion: nil)
    }
}

