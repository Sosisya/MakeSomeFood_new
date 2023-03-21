import UIKit

class LoginViewController: UIViewController {
    // - MARK: Constants
    private var scrollViewBottom: NSLayoutConstraint?
    private var agreementBottom: NSLayoutConstraint?

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
        return textfieldView
    }()

    private let enterButton: UIButton = {
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

    private let agreementLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "By logging into my account, I agree to the terms and conditions"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(named: "black")
        label.font = UIFont(name: "Montserrat-Medium", size: 13)
        return label
    }()

    private let tap = UITapGestureRecognizer(target: LoginViewController.self, action: #selector(UIInputViewController.dismissKeyboard))

    // -MARK:

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupConstraint()
        configureButton()
        configureNavigationBar()
        configurationNotificationCenter()
        configureTapGesture()
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
        contentView.addSubview(enterButton)
        registrationStackView.addArrangedSubview(registrationLabel)
        registrationStackView.addArrangedSubview(registrationButton)
        contentView.addSubview(registrationStackView)
        contentView.addSubview(agreementLabel)
    }

    public func setupConstraint() {
        scrollViewBottom = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        agreementBottom = agreementLabel.bottomAnchor.constraint(equalTo: registrationStackView.bottomAnchor, constant: 50)

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

            enterButton.topAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: 32),
            enterButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            enterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            enterButton.heightAnchor.constraint(equalToConstant: 56),

            registrationStackView.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 34),
            registrationStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            agreementBottom!,
            agreementLabel.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            agreementLabel.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),
            agreementLabel.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -8)
        ])
    }

    private func configureButton() {
        registrationButton.addTarget(self, action: #selector(registrationButtonAction), for: .touchUpInside)
        enterButton.addTarget(self, action: #selector(enterButtonAction), for: .touchUpInside)
    }

    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
               view.addGestureRecognizer(tapGesture)
    }

    @objc func registrationButtonAction() {
        let registrationVC = RegistrationViewController()
        self.show(registrationVC, sender: self)
    }

    @objc func enterButtonAction() {
        let profileVC = ProfileViewController()
        self.show(profileVC, sender: self)
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
        title = ""
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
     }

    private func createBottomLinks() {
        let filledHeight = registrationStackView.frame.maxY
        let fullHeight = scrollView.frame.height
        let minOffset = 8 + agreementLabel.frame.height
        let realOffSet = fullHeight - filledHeight - 18
        agreementBottom?.constant = max(realOffSet, minOffset)
    }
}
