import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
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
        return textfieldView
    }()

    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(UIColor(named: "white"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        button.backgroundColor = UIColor(named: "orange")
        button.layer.cornerRadius = 12
        return button
    }()

    private let registrationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()

    private let registrationLabel: UILabel = {
        let label = UILabel()
        label.tintColor = UIColor(named: "black")
        label.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        label.contentMode = .center
        label.numberOfLines = 1
        label.text = "First time here?"
        return label
    }()

    private let registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Registration", for: .normal)
        button.setTitleColor(UIColor(named: "green"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        return button
    }()

    private lazy var agreementTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .specialBlack
        textView.font = .montserratMedium13()
        textView.backgroundColor = .clear
        textView.delegate = self
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "By logging into my account, I agree to the terms and conditions"
        textView.addHyperLinksToText(originalText: "By logging into my account, I agree to the terms and conditions", hyperLinks: ["terms and conditions" : "http://makesomefood.tilda.ws/useragreement"])
        return textView
    }()

    private let tap = UITapGestureRecognizer(target: LoginViewController.self, action: #selector(UIInputViewController.dismissKeyboard))

    // -MARK:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupConstraint()
        configure()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            onAuth()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.createBottomLinks()
        }
    }
}

// -MARK: Extension
extension LoginViewController {
    public func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(emailTextFieldView)
        contentView.addSubview(passwordTextFieldView)
        contentView.addSubview(loginButton)
        registrationStackView.addArrangedSubview(registrationLabel)
        registrationStackView.addArrangedSubview(registrationButton)
        contentView.addSubview(registrationStackView)
        contentView.addSubview(agreementTextView)
    }

    public func setupConstraint() {
        scrollViewBottom = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        agreementBottom = agreementTextView.bottomAnchor.constraint(equalTo: registrationStackView.bottomAnchor, constant: 50)

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

            emailTextFieldView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 112),
            emailTextFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            emailTextFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            passwordTextFieldView.topAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 16),
            passwordTextFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordTextFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            loginButton.topAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: 32),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 56),

            registrationStackView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 34),
            registrationStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            agreementBottom!,
            agreementTextView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            agreementTextView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),
            agreementTextView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -8),
            agreementTextView.heightAnchor.constraint(equalToConstant: 38)
        ])
    }

    private func configure() {
        configureButton()
        configureNavigationBar()
        configurationNotificationCenter()
        configureTapGesture()
        setKeyboardButton()
    }

    private func configureButton() {
        registrationButton.addTarget(self, action: #selector(registrationButtonAction), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
    }

    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func registrationButtonAction() {
        let registrationVC = RegistrationViewController()
        registrationVC.onAuthAction = onAuthAction
        self.show(registrationVC, sender: self)
    }

    @objc func loginButtonAction() {
        Auth.auth().signIn(withEmail: emailTextFieldView.textField.text ?? "", password: passwordTextFieldView.textField.text ?? "") { [weak self] authResult, error in
            DispatchQueue.main.async {
                guard self != nil else { return }
                if authResult?.user != nil {
                    self?.onAuth()
                } else {
                    self?.showUserNotFoundAlert()
                }
            }
        }
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

    private func configureNavigationBar() {
        navigationItem.title = ""
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "icon.left")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "icon.left")
        navigationController?.navigationBar.tintColor = UIColor(named: "black")
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    private func createBottomLinks() {
        let filledHeight = registrationStackView.frame.maxY
        let fullHeight = scrollView.frame.height
        let minOffset = 8 + agreementTextView.frame.height
        let realOffSet = fullHeight - filledHeight - 18
        agreementBottom?.constant = max(realOffSet, minOffset)
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

    private func setKeyboardButton() {
        emailTextFieldView.textField.returnKeyType = .next
        emailTextFieldView.onReturnButtonTapped = { [weak self] in
            self?.passwordTextFieldView.textField.becomeFirstResponder()
            return true
        }
        passwordTextFieldView.textField.returnKeyType = .done
        passwordTextFieldView.onReturnButtonTapped = { [weak self] in
            self?.passwordTextFieldView.textField.resignFirstResponder()
            self?.loginButtonAction()
            return true
        }
        passwordTextFieldView.textField.isSecureTextEntry = true
    }

    private func showUserNotFoundAlert() {
        let alert = UIAlertController(title: "User not found", message: "Invalid e-mail or password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

extension LoginViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
          if #available(iOS 13, *) {
              textView.selectedTextRange = nil
          } else {
              view.endEditing(true)
          }
      }
}
