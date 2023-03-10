import Foundation

struct CategoriesList: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let id: String
    let category: String
    let thumb: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case category = "strCategory"
        case thumb = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}
