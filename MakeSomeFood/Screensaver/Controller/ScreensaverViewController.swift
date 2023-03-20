import UIKit

class ScreensaverViewController: UIViewController {

    struct Spec {
        static let upperNameLabelText = "make some"
        static let lowerNameLabelText = "food"
        static let screensaverImageView = UIImage(named: "screensaver")
    }

    private let screensaverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translates()
        imageView.image = Spec.screensaverImageView
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let upperNameLabel: UILabel = {
        let label = UILabel()
        label.translates()
        label.tintColor = .specialBlack
        label.textAlignment = .center
        label.font = .montserratBold44()
        label.text = Spec.upperNameLabelText
        return label
    }()

    private let lowerNameLabel: UILabel = {
        let label = UILabel()
        label.translates()
        label.textColor = .specialOrange
        label.textAlignment = .center
        label.font = .montserratBold53()
        label.text = Spec.lowerNameLabelText
        return label
    }()

    var completionHandler = {}

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.completionHandler()
        }
    }
}

extension ScreensaverViewController {
    private func setupLayout() {
        view.addSubview(screensaverImageView)
        view.addSubview(upperNameLabel)
        view.addSubview(lowerNameLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            screensaverImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            screensaverImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            screensaverImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            screensaverImageView.heightAnchor.constraint(equalToConstant: 297),
            upperNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 224),
            upperNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lowerNameLabel.trailingAnchor.constraint(equalTo: upperNameLabel.trailingAnchor),
            lowerNameLabel.topAnchor.constraint(equalTo: upperNameLabel.bottomAnchor),
        ])
    }
}
