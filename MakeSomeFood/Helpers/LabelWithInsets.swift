import UIKit

class LabelWithInsets: UILabel {

    private struct Spec {
        static var insetTop: CGFloat = 4
        static var insetLeft: CGFloat = 8
        static var insetBottom: CGFloat = 4
        static var insetRight: CGFloat = 8
        static var contentSizeWidth: CGFloat = 16
        static var contentSizeHeight: CGFloat = 8
    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: Spec.insetTop, left: Spec.insetLeft, bottom: Spec.insetBottom, right: Spec.insetRight)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += Spec.contentSizeWidth
        size.height += Spec.contentSizeHeight
        return size
    }
}
