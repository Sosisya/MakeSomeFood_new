import UIKit

class CookingHeaderTableViewCell: UITableViewCell {
    private let headerView: CookingFooterView = {
        let view = CookingFooterView()
        view.translates()
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

extension CookingHeaderTableViewCell {
    private func setupLayout() {
        contentView.addSubview(headerView)
    }

    private func setupConstraits() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
    }
}
