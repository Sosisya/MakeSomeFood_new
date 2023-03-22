import UIKit

class TagCollectionViewCell: UICollectionViewCell {

    // - MARK: -
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints()
        view.setCornerRadius(radius: 17)
        view.setMasksToBounds()
        view.backgroundColor = .specialOrange
        return view
    }()

    let tagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints()
        label.font = UIFont.montserratMedium16()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // - MARK: -
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

            tagLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            tagLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            tagLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            tagLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4)
        ])
    }
}
