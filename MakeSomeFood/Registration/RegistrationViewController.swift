import UIKit

class RegistrationViewController: UIViewController {

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
        label.textAlignment = .center
        label.tintColor = UIColor(named: "gray")
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setConstraints()
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
        contentView.addSubview(agreementLabel)
    }

    private func setConstraints() {
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

            agreementLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            agreementLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            agreementLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
