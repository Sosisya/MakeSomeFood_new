import Foundation

struct ReсipeList: Decodable {
    let meals: [Recipe]
}

struct Recipe: Decodable {
    let id: String
    let name: String
    let drink: String?
    let category: String
    let area: String
    let instruction: String?
    let thumb: String?
    let tags: String?
    let video: String?
    let ingredients: [String]
    let measures: [String]
    let source: String?
    let imageSource: String?
    let creativeCommonsConfirmed: String?
    let dateModified: String?

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case drink = "strDrinkAlternate"
        case category = "strCategory"
        case area = "strArea"
        case instruction = "strInstructions"
        case thumb = "strMealThumb"
        case tags = "strTags"
        case video = "strYoutube"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
        case measure6 = "strMeasure6"
        case measure7 = "strMeasure7"
        case measure8 = "strMeasure8"
        case measure9 = "strMeasure9"
        case measure10 = "strMeasure10"
        case measure11 = "strMeasure11"
        case measure12 = "strMeasure12"
        case measure13 = "strMeasure13"
        case measure14 = "strMeasure14"
        case measure15 = "strMeasure15"
        case measure16 = "strMeasure16"
        case measure17 = "strMeasure17"
        case measure18 = "strMeasure18"
        case measure19 = "strMeasure19"
        case measure20 = "strMeasure20"
        case source = "strSource"
        case imageSource = "strImageSource"
        case creativeCommonsConfirmed = "strCreativeCommonsConfirmed"
        case dateModified = "dateModified"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        drink = try? values.decode(String.self, forKey: .drink)
        category = try values.decode(String.self, forKey: .category)
        area = try values.decode(String.self, forKey: .area)
        instruction = try? values.decode(String.self, forKey: .instruction)
        thumb = try? values.decode(String.self, forKey: .thumb)
        tags = try? values.decode(String.self, forKey: .tags)
        video = try? values.decode(String.self, forKey: .video)
        source = try? values.decode(String.self, forKey: .source)
        imageSource = try? values.decode(String.self, forKey: .imageSource)
        creativeCommonsConfirmed = try? values.decode(String.self, forKey: .creativeCommonsConfirmed)
        dateModified = try? values.decode(String.self, forKey: .dateModified)
        let ingredientStrings: [String?] = [
            try? values.decode(String.self, forKey: .ingredient1),
            try? values.decode(String.self, forKey: .ingredient2),
            try? values.decode(String.self, forKey: .ingredient3),
            try? values.decode(String.self, forKey: .ingredient4),
            try? values.decode(String.self, forKey: .ingredient5),
            try? values.decode(String.self, forKey: .ingredient6),
            try? values.decode(String.self, forKey: .ingredient7),
            try? values.decode(String.self, forKey: .ingredient8),
            try? values.decode(String.self, forKey: .ingredient9),
            try? values.decode(String.self, forKey: .ingredient10),
            try? values.decode(String.self, forKey: .ingredient11),
            try? values.decode(String.self, forKey: .ingredient12),
            try? values.decode(String.self, forKey: .ingredient13),
            try? values.decode(String.self, forKey: .ingredient14),
            try? values.decode(String.self, forKey: .ingredient15),
            try? values.decode(String.self, forKey: .ingredient16),
            try? values.decode(String.self, forKey: .ingredient17),
            try? values.decode(String.self, forKey: .ingredient18),
            try? values.decode(String.self, forKey: .ingredient19),
            try? values.decode(String.self, forKey: .ingredient20)
        ]
        let measuresArray: [String?] = [
            try? values.decode(String.self, forKey: .measure1),
            try? values.decode(String.self, forKey: .measure2),
            try? values.decode(String.self, forKey: .measure3),
            try? values.decode(String.self, forKey: .measure4),
            try? values.decode(String.self, forKey: .measure5),
            try? values.decode(String.self, forKey: .measure6),
            try? values.decode(String.self, forKey: .measure7),
            try? values.decode(String.self, forKey: .measure8),
            try? values.decode(String.self, forKey: .measure9),
            try? values.decode(String.self, forKey: .measure10),
            try? values.decode(String.self, forKey: .measure11),
            try? values.decode(String.self, forKey: .measure12),
            try? values.decode(String.self, forKey: .measure13),
            try? values.decode(String.self, forKey: .measure14),
            try? values.decode(String.self, forKey: .measure15),
            try? values.decode(String.self, forKey: .measure16),
            try? values.decode(String.self, forKey: .measure17),
            try? values.decode(String.self, forKey: .measure18),
            try? values.decode(String.self, forKey: .measure19),
            try? values.decode(String.self, forKey: .measure20)
        ]
        measures = measuresArray.compactMap { $0 }
        ingredients = ingredientStrings.compactMap { $0 }.filter {
            !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }
    func mapToDict() -> NSDictionary {
        return [
            "id": id,
            "name": name,
            "drink": drink as Any,
            "category": category,
            "area": area,
            "instruction": instruction as Any,
            "thumb": thumb as Any,
            "tags": tags as Any,
            "video": video as Any,
            "ingredients": ingredients,
            "measures": measures,
            "source": source as Any,
            "imageSource": imageSource as Any,
            "creativeCommonsConfirmed": creativeCommonsConfirmed as Any,
            "dateModified": dateModified as Any
        ]
    }
    init(dict: NSDictionary) {
        self.id = dict["id"] as! String
        self.name = dict["name"] as! String
        self.drink = dict["drink"] as? String
        self.category = dict["category"] as! String
        self.area = dict["area"] as! String
        self.instruction = dict["instruction"] as? String
        self.thumb = dict["thumb"] as? String
        self.tags = dict["tags"] as? String
        self.video = dict["video"] as? String
        let ingredients = dict["ingredients"] as? NSArray ?? []
        self.ingredients = ingredients.compactMap { $0 as? String }
        let measures = dict["measures"] as? NSArray ?? []
        self.measures = measures.compactMap { $0 as? String }
        self.source = dict["source"] as? String
        self.imageSource = dict["imageSource"] as? String
        self.creativeCommonsConfirmed = dict["creativeCommonsConfirmed"] as? String
        self.dateModified = dict["dateModified"] as? String
    }
    init(recipeOfCategory: RecipeOfCategory) {
        self.id = recipeOfCategory.id
        self.name = recipeOfCategory.name
        self.drink = nil
        self.category = ""
        self.area = ""
        self.instruction = nil
        self.thumb = recipeOfCategory.thumb
        self.tags = nil
        self.video = nil
        self.ingredients = []
        self.measures = []
        self.source = nil
        self.imageSource = nil
        self.creativeCommonsConfirmed = nil
        self.dateModified = nil
    }
}

