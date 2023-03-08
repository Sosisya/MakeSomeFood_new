import UIKit

// MARK: - extension UIView
extension UIView {
    func rounded(radius: CGFloat = 12) {
        self.layer.cornerRadius = radius
    }

    func translates() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    func bordered() {
        self.layer.borderWidth = 1
    }

    func colored(color: UIColor = .specialBlack) {
        self.layer.borderColor = color.cgColor
    }

    func masked(_ bool: Bool) {
        self.layer.masksToBounds = bool
    }
}
