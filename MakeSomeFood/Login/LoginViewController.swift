import UIKit
class LoginViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .red
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
        label.text = "Agreement"
        label.textAlignment = .left
        label.tintColor = UIColor(named: "gray")
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        return label
    }()

    private let tap = UITapGestureRecognizer(target: LoginViewController.self, action: #selector(UIInputViewController.dismissKeyboard))

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupConstraint()
        configureButton()
        configureNavigationBar()
    }
}

extension LoginViewController {
    public func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(contentView)
        contentView.addSubview(emailTextFieldView)
        contentView.addSubview(passwordTextFieldView)
        contentView.addSubview(enterButton)
        registrationStackView.addArrangedSubview(registrationLabel)
        registrationStackView.addArrangedSubview(registrationButton)
        contentView.addSubview(registrationStackView)
    }

    public func setupConstraint() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

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
            registrationStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    private func configureButton() {
        registrationButton.addTarget(self, action: #selector(registrationButtonAction), for: .touchUpInside)
        enterButton.addTarget(self, action: #selector(enterButtonAction), for: .touchUpInside)
    }

    @objc func registrationButtonAction() {
        let registrationVC = RegistrationViewController()
        self.present(registrationVC, animated: true)
    }

    @objc func enterButtonAction() {
        let profileVC = ProfileViewController()
        self.present(profileVC, animated: true)
    }

    private func configureNavigationBar() {
        title = ""
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
     }
}
