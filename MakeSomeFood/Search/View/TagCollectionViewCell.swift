import UIKit

class TagCollectionViewCell: UICollectionViewCell {

    private var containerView: UIView = {
        let view = UIView()
        view.translates()
        view.rounded()
        view.backgroundColor = .specialOrange
        return view
    }()

    private let tagLabel: UILabel = {
        let label = UILabel()
        label.translates()
        label.text = "Tag"
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
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -6),
            containerView.heightAnchor.constraint(equalToConstant: 34),

            tagLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            tagLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
    }
}
