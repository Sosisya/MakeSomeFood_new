import Foundation

struct CategoriesTagList: Codable {
    let meals: [CategoryTag]
}

struct CategoryTag: Codable {
    let category: String

    enum CodingKeys: String, CodingKey {
        case category = "strCategory"
    }
}
