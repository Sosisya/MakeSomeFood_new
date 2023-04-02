import UIKit

class TagCollectionViewCell: UICollectionViewCell {

    // - MARK: -
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
        self.setCornerRadius(radius: 17)
    }
}

extension TagCollectionViewCell {
    private func setuprLayout() {
        addSubview(tagLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 34),
            tagLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            tagLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tagLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tagLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
}
