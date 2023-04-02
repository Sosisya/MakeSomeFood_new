import UIKit

enum TagsType {
    case category
    case area
    case ingredient

    var color: UIColor {
        switch self {
        case .category: return .specialOrange
        case .area: return .specialGreen
        case .ingredient: return .specialOrange
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


