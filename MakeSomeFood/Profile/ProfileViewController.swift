import UIKit

class ProfileViewController: UIViewController {

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "profile")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let takePhotoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.setTitleColor(UIColor(named: "white"), for: .normal)
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

    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign in", for: .normal)
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
        button.layer.cornerRadius = 12
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupConstraint()
    }

    func setupLayout() {
        view.addSubview(profileImageView)
        view.addSubview(takePhotoButton)
        view.addSubview(nameTextFieldView)
        view.addSubview(emailTextFieldView)
        view.addSubview(saveButton)
        view.addSubview(exitButton)
    }
}

extension ProfileViewController {
    func setupConstraint() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),

            takePhotoButton.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 64),
            takePhotoButton.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: 64),
            takePhotoButton.heightAnchor.constraint(equalToConstant: 44),
            takePhotoButton.widthAnchor.constraint(equalToConstant: 44)



        ])

    }
}


import SwiftUI
struct ListProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
            .previewDevice("iPhone 14 Pro Max")
            .previewDisplayName("iPhone 14 Pro Max")
    }

    struct ContainterView: UIViewControllerRepresentable {
        let listVC = ProfileViewController()
        func makeUIViewController(context:
                                  UIViewControllerRepresentableContext<ListProvider.ContainterView>) -> ProfileViewController {
            return listVC
        }

        func updateUIViewController(_ uiViewController:
                                    ListProvider.ContainterView.UIViewControllerType, context:
                                    UIViewControllerRepresentableContext<ListProvider.ContainterView>) {
        }
    }
}

