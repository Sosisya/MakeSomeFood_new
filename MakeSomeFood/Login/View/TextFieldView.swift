import UIKit
//Как сделать плавающий текст филд если у меня нет констраинтов?
class TextFieldView: UIView, UITextFieldDelegate {

    private let containerView: UIView = {
        let containerView = UIView()
        containerView.layer.masksToBounds = false
        containerView.layer.cornerRadius = 12
        containerView.layer.borderColor = UIColor(named: "grayFill")?.cgColor
        containerView.layer.borderWidth = 1
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    private let textField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.borderStyle = .none
        return textfield
    }()

    let floatingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Luiza"
        label.tintColor = UIColor(named: "gray")
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        return label
    }()

    let topConstraint: CGFloat = 16
    var topLabelConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        setupLayout()
        setupConstraints()
        textField.delegate = self
    }
}

extension TextFieldView {
    func setupLayout() {
        addSubview(containerView)
        addSubview(textField)
        addSubview(floatingLabel)
    }

    func setupConstraints() {
        topLabelConstraint = floatingLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: topConstraint)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 56),

            textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),

            topLabelConstraint!,
            floatingLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
        ])
    }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            floatTitle()
//            performAnimation(transform: CGAffineTransform(scaleX: 1, y: 1))
        }

        func floatTitle() {
            floatingLabel.font = UIFont(name: "Montserrat-Regular", size: 12)
            topLabelConstraint?.constant = 8
            containerView.layer.borderColor = UIColor(named: "black")?.cgColor
        }

//        private func performAnimation(transform: CGAffineTransform) {
//            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
//                self.textFieldLabel.transform = transform
//                self.layoutIfNeeded()
//            }, completion: nil)
//        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            if textField.text?.isEmpty ?? false {
                configureEndEditing()
            }
        }

        func unfloatTitle() {
//            textField.placeholder = nil
//            topLabelCostraint.constant = 20
//            leadingLabelCostraint.constant = 12
//            textFieldLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
            containerView.layer.borderColor = UIColor(named: "grayTextField")?.cgColor
        }

        private func configureEndEditing() {
            unfloatTitle()
//            performAnimation(transform: CGAffineTransform(scaleX: 1, y: 1))
        }
}



//import UIKit
//
//class TextFieldView: UIView, UITextFieldDelegate {
//
//    @IBOutlet weak var contentView: UIView!
//    @IBOutlet weak var textFieldLabel: UILabel!
//    @IBOutlet weak var textField: UITextField!
//    @IBOutlet weak var leadingLabelCostraint: NSLayoutConstraint!
//    @IBOutlet weak var topLabelCostraint: NSLayoutConstraint!
//
//    var onReturnButtonTapped: () -> Bool = { true }
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        textField.delegate = self
//        setShapes()
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        onReturnButtonTapped()
//    }
//
//    func setShapes() {
//        contentView.layer.masksToBounds = true
//        contentView.layer.borderWidth = 1
//        contentView.layer.borderColor = UIColor(named: "grayTextField")?.cgColor
//        contentView.layer.cornerRadius = 12
//        textField.font = UIFont(name: "Montserrat-Regular", size: 16)
//        textField.textColor = UIColor(named: "black")
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        floatTitle()
//        performAnimation(transform: CGAffineTransform(scaleX: 1, y: 1))
//    }
//
//    func floatTitle() {
//        textFieldLabel.font = UIFont(name: "Montserrat-Regular", size: 12)
//        topLabelCostraint.constant = 8
//        leadingLabelCostraint.constant = 12
//        contentView.layer.borderColor = UIColor(named: "black")?.cgColor
//    }
//
//    private func performAnimation(transform: CGAffineTransform) {
//        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
//            self.textFieldLabel.transform = transform
//            self.layoutIfNeeded()
//        }, completion: nil)
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField.text?.isEmpty ?? false {
//            configureEndEditing()
//        }
//    }
//
//    func unfloatTitle() {
//        textField.placeholder = nil
//        topLabelCostraint.constant = 20
//        leadingLabelCostraint.constant = 12
//        textFieldLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
//        contentView.layer.borderColor = UIColor(named: "grayTextField")?.cgColor
//    }
//
//    private func configureEndEditing() {
//        unfloatTitle()
//        performAnimation(transform: CGAffineTransform(scaleX: 1, y: 1))
//    }
//
//}


