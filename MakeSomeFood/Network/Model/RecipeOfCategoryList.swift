import Foundation

struct RecipesOfCategoryList: Codable {
    let meals: [RecipeOfCategory]
}

struct RecipeOfCategory: Codable {
    let name: String
    let thumb: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case thumb = "strMealThumb"
        case id = "idMeal"
    }
}
