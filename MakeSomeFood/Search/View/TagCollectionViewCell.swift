import UIKit

class TagCollectionViewCell: UICollectionViewCell {

    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.layer.cornerRadius = 12
        return view
    }()

    private let tagLabel: UILabel = {
        let label = UILabel()
        label.text = "Tag"
        label.textColor = .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
