import UIKit

enum TagsType {
    case category
    case area
    case ingredient

    var color: UIColor {
        switch self {
        case .category: return UIColor(named: "orange")!
        case .area: return UIColor(named: "green")!
        case .ingredient: return UIColor(named: "orange")!
        }
    }

    var title: String {
        switch self {
        case .category: return "All categories"
        case .area: return "All areas"
        case .ingredient: return "All ingreidents"
        }
    }

    var filterId: String {
        switch self {
        case .category: return "c"
        case .area: return "a"
        case .ingredient: return "i"
        }
    }
}


