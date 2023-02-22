import UIKit

class ScreensaverViewController: UIViewController {

    private let screensaverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "screensaver")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let upperNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = UIColor(named: "black")
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 44)
        label.text = "make some"
        return label
    }()

    private let lowerNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "orange")
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 53)
        label.text = "food"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
        setConstraint()
    }

    func setLayout() {
        view.addSubview(screensaverImageView)
        view.addSubview(upperNameLabel)
        view.addSubview(lowerNameLabel)
    }

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.performSegue(withIdentifier: "toAuth", sender: self)
//        }
//    }
}

extension ScreensaverViewController {
    func setConstraint() {
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



