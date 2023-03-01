import UIKit

class HeaderView: UITableViewHeaderFooterView {
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Special"
        label.font = UIFont(name: "Montserrat-Medium", size: 22)
        label.tintColor = UIColor(named: "black")
        return label
    }()

    private let headerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("All recipes", for: .normal)
        button.tintColor = UIColor(named: "green")
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 13)
        return button
    }()

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
        setupContsraints()
    }
}

extension HeaderView {
    private func setupLayout() {
        addSubview(headerLabel)
        addSubview(headerButton)
    }

    private func setupContsraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),

            headerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            headerButton.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: 16),
            headerButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
        ])
    }
}
