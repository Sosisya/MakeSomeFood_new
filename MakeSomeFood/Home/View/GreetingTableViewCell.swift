import UIKit

class GreetingTableViewCell: UITableViewCell {
    
    private let containerView: UIView = {
         let view = UIView()
         view.translates()
         return view
     }()

     private let greetingLabel: UILabel = {
         let label = UILabel()
         label.translates()
         label.text = "Hello, guest!"
         label.textColor = UIColor(named: "black")
         label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
         return label
     }()

     private let profileImage: UIImageView = {
         let imageView = UIImageView()
         imageView.translates()
         imageView.image = UIImage(named: "profile")
         imageView.contentMode = .scaleAspectFill
         imageView.layer.masksToBounds = true
         imageView.layer.cornerRadius = 12
         return imageView
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
         setupConstraints()
     }
 }

extension GreetingTableViewCell {
    private func setupLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(greetingLabel)
        containerView.addSubview(profileImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            greetingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            greetingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            profileImage.centerYAnchor.constraint(equalTo: greetingLabel.centerYAnchor),
            profileImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            profileImage.heightAnchor.constraint(equalToConstant: 42),
            profileImage.widthAnchor.constraint(equalToConstant: 42)
        ])
    }
}
