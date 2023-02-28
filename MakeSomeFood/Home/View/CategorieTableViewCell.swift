import UIKit

class CategorieTableViewCell: UITableViewCell {

    private var categorieView: CategorieView = {
        let view = CategorieView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
        setupConstrait()
    }

    func setupLayout() {
        self.addSubview(categorieView)
    }

    func setupConstrait() {
        NSLayoutConstraint.activate([
            categorieView.topAnchor.constraint(equalTo: self.topAnchor),
            categorieView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            categorieView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            categorieView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
