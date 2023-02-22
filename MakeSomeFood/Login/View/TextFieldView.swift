import UIKit

class TextFieldView: UIView {

    let textfield: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .none
        return textfield
    }()

    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.tintColor = UIColor(named: "gray")
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
        setupConstraint()
    }

    func setupLayout() {
        self.addSubview(textfield)
        self.addSubview(placeholderLabel)
    }
}

extension TextFieldView {
    func setupConstraint() {
        NSLayoutConstraint.activate([
            textfield.topAnchor.constraint(equalTo: self.topAnchor),
            textfield.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textfield.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textfield.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            placeholderLabel.topAnchor.constraint(equalTo: textfield.topAnchor, constant: 16),
            placeholderLabel.leadingAnchor.constraint(equalTo: textfield.leadingAnchor, constant: 12),
            placeholderLabel.trailingAnchor.constraint(equalTo: textfield.trailingAnchor, constant: -12),
            placeholderLabel.bottomAnchor.constraint(equalTo: textfield.bottomAnchor, constant: -16),
        ])

    }
}


