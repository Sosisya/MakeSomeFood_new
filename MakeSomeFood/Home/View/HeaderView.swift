import UIKit

class HeaderView: UITableViewHeaderFooterView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translates()
        label.font = .montserratMedium22()
        label.tintColor = .specialBlack
        return label
    }()

    let headerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translates()
        button.tintColor = .specialGreen
        button.titleLabel?.font = .montserratMedium13()
        return button
    }()

    private var buttonAction: () -> Void = {}

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupLayout()
        configureButton()
        setupContsraints()
    }
    
    func configure(title: String, actionTitle: String? = nil, action: @escaping () -> Void = {}) {
        headerLabel.text = title
        if let actionTitle = actionTitle {
            headerButton.isHidden = false
            headerButton.setTitle(actionTitle, for: .normal)
        } else {
            headerButton.isHidden = true
        }
        buttonAction = action
    }

    func configureButton() {
        headerButton.addTarget(self, action: #selector(headerButtonTapped), for: .touchUpInside)
    }

    @objc func headerButtonTapped() {
        buttonAction()
    }
}

extension HeaderView {
    private func setupLayout() {
        addSubview(headerLabel)
        addSubview(headerButton)
    }

    private func setupContsraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            headerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            headerButton.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: 16),
            headerButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
        ])
    }
}
