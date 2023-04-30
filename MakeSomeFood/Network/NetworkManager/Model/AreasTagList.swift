import Foundation

struct AreasTagList: Codable {
    let meals: [AreaTag]
}

struct AreaTag: Codable {
    let area: String

    enum CodingKeys: String, CodingKey {
        case area = "strArea"
    }
}
