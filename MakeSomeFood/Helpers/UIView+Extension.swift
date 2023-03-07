import UIKit

// MARK: - extension UIView
extension UIView {
    func rounded(radius: CGFloat = 12) {
        self.layer.cornerRadius = radius
    }

    func translates() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
