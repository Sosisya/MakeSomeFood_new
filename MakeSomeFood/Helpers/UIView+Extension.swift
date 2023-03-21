import UIKit

// MARK: - extension UIView
extension UIView {
    func setCornerRadius(radius: CGFloat = 12) {
        self.layer.cornerRadius = radius
    }

    func translatesAutoresizingMaskIntoConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    func setBorderWidth() {
        self.layer.borderWidth = 1
    }

    func setColor(color: UIColor = .specialBlack) {
        self.layer.borderColor = color.cgColor
    }

    func setMasksToBounds(_ bool: Bool = true) {
        self.layer.masksToBounds = bool
    }
}
