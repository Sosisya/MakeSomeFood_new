import UIKit

class TagCollectionViewCell: UICollectionViewCell {

    private var containerView: UIView = {
        let view = UIView()
        view.translates()
        view.backgroundColor = .cyan
        view.layer.cornerRadius = 12
        return view
    }()

    private let tagLabel: UILabel = {
        let label = UILabel()
        label.translates()
        label.text = "Tag"
        label.textColor = .black
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
        setuprLayout()
        setupConstraints()
    }
}

extension TagCollectionViewCell {
    private func setuprLayout() {
        contentView.addSubview(containerView)
        contentView.addSubview(tagLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            tagLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            tagLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
    }
}
