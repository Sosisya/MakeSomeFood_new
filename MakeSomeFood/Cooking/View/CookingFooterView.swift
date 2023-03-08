import UIKit

class CookingFooterView: UIView {
    let headerLabel: UILabel = {
        let label = UILabel()
        label.translates()
        label.font = .montserratMedium22()
        label.tintColor = .specialBlack
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
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

extension CookingFooterView {
    private func setupLayout() {
        addSubview(headerLabel)
    }

    private func setupContsraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
