import UIKit

class RegistrationViewController: UIViewController {

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

    private let nameTextFieldView: TextFieldView = {
        let textfieldView = TextFieldView()
        textfieldView.translatesAutoresizingMaskIntoConstraints = false
        textfieldView.layer.cornerRadius = 12
        textfieldView.layer.borderColor = UIColor(named: "grayFill")?.cgColor
        textfieldView.layer.borderWidth = 1
        textfieldView.placeholderLabel.text = "Name"
        return textfieldView
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

    private let agreementLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Agreement"
        label.textAlignment = .left
        label.tintColor = UIColor(named: "gray")
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.addSubview(emailTextFieldView)
        scrollView.addSubview(passwordTextFieldView)
        scrollView.addSubview(registrationButton)
        scrollView.addSubview(agreementLabel)
    }
}

extension RegistrationViewController {
    func setConstraint() {
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            nameTextFieldView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 112),
            nameTextFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameTextFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameTextFieldView.heightAnchor.constraint(equalToConstant: 56),

            emailTextFieldView.topAnchor.constraint(equalTo: nameTextFieldView.bottomAnchor, constant: 16),
            emailTextFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            emailTextFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            emailTextFieldView.heightAnchor.constraint(equalToConstant: 56),

            passwordTextFieldView.topAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 16),
            passwordTextFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordTextFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            passwordTextFieldView.heightAnchor.constraint(equalToConstant: 56),

            registrationButton.topAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: 32),
            registrationButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            registrationButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            registrationButton.heightAnchor.constraint(equalToConstant: 56),


            agreementLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
            agreementLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            agreementLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}


