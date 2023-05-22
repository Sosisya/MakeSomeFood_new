import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController {
    // - MARK: Constants
    private var scrollViewBottom: NSLayoutConstraint?
    private var agreementBottom: NSLayoutConstraint?
    public var onAuthAction: (() -> Void)?

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

    private let registrationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        label.textColor = UIColor(named: "black")
        label.text = "Registration"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let nameTextFieldView: TextFieldView = {
        let textfieldView = TextFieldView()
        textfieldView.translatesAutoresizingMaskIntoConstraints = false
        textfieldView.floatingLabel.text = "Name"
        return textfieldView
    }()

    private let emailTextFieldView: TextFieldView = {
        let textfieldView = TextFieldView()
        textfieldView.translatesAutoresizingMaskIntoConstraints = false
        textfieldView.floatingLabel.text = "E-mail"
        return textfieldView
    }()

    private let passwordTextFieldView: TextFieldView = {
        let textfieldView = TextFieldView()
        textfieldView.translatesAutoresizingMaskIntoConstraints = false
        textfieldView.floatingLabel.text = "Password"
        textfieldView.textField.isSecureTextEntry = true
        textfieldView.textField.textContentType = .oneTimeCode
        return textfieldView
    }()

    private let registrationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Registraition", for: .normal)
        button.setTitleColor(UIColor(named: "white"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        button.backgroundColor = UIColor(named: "orange")
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var agreementTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .specialBlack
        textView.font = .montserratMedium13()
        textView.delegate = self
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "By registering, I agree to the terms and conditions"
        textView.addHyperLinksToText(originalText: "By registering, I agree to the terms and conditions", hyperLinks: ["terms and conditions" : "http://makesomefood.tilda.ws/useragreement"])
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setConstraints()
        configurationNotificationCenter()
        configureTapGesture()
        configureButton()
        setKeyboardButton()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.createBottomLinks()
        }
    }
}

extension RegistrationViewController {
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(registrationLabel)
        contentView.addSubview(nameTextFieldView)
        contentView.addSubview(emailTextFieldView)
        contentView.addSubview(passwordTextFieldView)
        contentView.addSubview(registrationButton)
        contentView.addSubview(agreementTextView)
    }

    private func setConstraints() {
        scrollViewBottom = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        agreementBottom = agreementTextView.bottomAnchor.constraint(equalTo: registrationButton.bottomAnchor, constant: 50)

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

            registrationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            registrationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            registrationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            nameTextFieldView.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 24),
            nameTextFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameTextFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            emailTextFieldView.topAnchor.constraint(equalTo: nameTextFieldView.bottomAnchor, constant: 16),
            emailTextFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            emailTextFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            passwordTextFieldView.topAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 16),
            passwordTextFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordTextFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            registrationButton.topAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: 32),
            registrationButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            registrationButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            registrationButton.heightAnchor.constraint(equalToConstant: 56),
            
            agreementBottom!,
            agreementTextView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            agreementTextView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),
            agreementTextView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -8),
            agreementTextView.heightAnchor.constraint(equalToConstant: 38)
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

    private func createBottomLinks() {
        let filledHeight = registrationButton.frame.maxY
        let fullHeight = scrollView.frame.height
        let minOffset = 8 + agreementTextView.frame.height
        let realOffSet = fullHeight - filledHeight - 18
        agreementBottom?.constant = max(realOffSet, minOffset)
    }

    private func configureButton() {
        registrationButton.addTarget(self, action: #selector(registrationAction), for: .touchUpInside)
    }

    @objc private func registrationAction() {
        Auth.auth().createUser(withEmail: emailTextFieldView.textField.text ?? "", password: passwordTextFieldView.textField.text ?? "") { [weak self] authResult, error in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                if authResult?.user != nil {
                    self?.setDisplayName()
                }
            }
        }
    }

    private func onAuth() {
        if let onAuthAction {
            onAuthAction()
        } else {
            let vc = ProfileViewController()
            let navVC = navigationController
            navVC?.viewControllers = [vc]
        }
    }

    private func setDisplayName() {
        UserManager.shared.changeDisplayName(name: nameTextFieldView.textField.text ?? "") { [weak self] in
            self?.onAuth()
        }
    }

    private func setKeyboardButton() {
        nameTextFieldView.textField.returnKeyType = .next
        nameTextFieldView.onReturnButtonTapped = { [weak self] in
            self?.emailTextFieldView.textField.becomeFirstResponder()
            return true
        }

        emailTextFieldView.textField.returnKeyType = .next
        emailTextFieldView.onReturnButtonTapped = { [weak self] in
            self?.passwordTextFieldView.textField.becomeFirstResponder()
            return true
        }
        passwordTextFieldView.textField.returnKeyType = .done
        passwordTextFieldView.onReturnButtonTapped = { [weak self] in
            self?.passwordTextFieldView.textField.resignFirstResponder()
            self?.registrationAction()
            return true
        }
        passwordTextFieldView.textField.isSecureTextEntry = true
    }
}

extension RegistrationViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
          if #available(iOS 13, *) {
              textView.selectedTextRange = nil
          } else {
              view.endEditing(true)
          }
      }
}
