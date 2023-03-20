import UIKit

class InstructionsTableViewCell: UITableViewCell {
    struct Spec {
        static let instructionsLabelText = "Instructions"
        static let numberOfInstructionsLabelLines = 0
    }

    let instructionsLabel: UILabel = {
        let label = UILabel()
        label.translates()
        label.text = Spec.instructionsLabelText
        label.font = .montserratRegular16()
        label.textColor = .specialBlack
        label.textAlignment = .left
        label.numberOfLines = Spec.numberOfInstructionsLabelLines
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupLayout()
        setupConstraits()
    }
}

extension InstructionsTableViewCell {
    private func setupLayout() {
        contentView.addSubview(instructionsLabel)
    }

    private func setupConstraits() {
        NSLayoutConstraint.activate([
            instructionsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            instructionsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            instructionsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            instructionsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
