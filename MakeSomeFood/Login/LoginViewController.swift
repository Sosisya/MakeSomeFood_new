import UIKit

class LoginViewController: UIViewController {

    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private let emailTextFieldView: TextFieldView = {
        let textfieldView = TextFieldView()
        textfieldView.translatesAutoresizingMaskIntoConstraints = false
        textfieldView.layer.cornerRadius = 12
        textfieldView.layer.borderColor = UIColor(named: "grayFill")?.cgColor
        textfieldView.layer.borderWidth = 1
        textfieldView.placeholderLabel.text = "E-mail"
        return textfieldView
    }()

    private let passwordTextFieldView: TextFieldView = {
        let textfieldView = TextFieldView()
        textfieldView.translatesAutoresizingMaskIntoConstraints = false
        textfieldView.layer.cornerRadius = 12
        textfieldView.layer.borderColor = UIColor(named: "grayFill")?.cgColor
        textfieldView.layer.borderWidth = 1
        textfieldView.placeholderLabel.text = "Password"
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

    private var registrationStackView: UIStackView = {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupConstraint()
    }


    func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.addSubview(emailTextFieldView)
        scrollView.addSubview(passwordTextFieldView)
        scrollView.addSubview(enterButton)
        registrationStackView.addArrangedSubview(registrationLabel)
        registrationStackView.addArrangedSubview(registrationButton)
        scrollView.addSubview(registrationStackView)
    }
}

extension LoginViewController {
    func setupConstraint() {
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            emailTextFieldView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 200),
            emailTextFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            emailTextFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            emailTextFieldView.heightAnchor.constraint(equalToConstant: 56),

            passwordTextFieldView.topAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 16),
            passwordTextFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordTextFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            passwordTextFieldView.heightAnchor.constraint(equalToConstant: 56),

            enterButton.topAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: 32),
            enterButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            enterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            enterButton.heightAnchor.constraint(equalToConstant: 56),

            registrationStackView.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 34),
            registrationStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}



