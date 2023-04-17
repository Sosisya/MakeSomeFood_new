//
//  IngredientsTagList.swift
//  MakeSomeFood
//
//  Created by Луиза Самойленко on 20.03.2023.
//

import Foundation

struct IngredientsTagList: Codable {
    let meals: [IngredientTag]
}

struct IngredientTag: Codable {
    let id: String
    let ingredient: String
    let description: String?

    enum CodingKeys: String, CodingKey {
        case id = "idIngredient"
        case ingredient = "strIngredient"
        case description = "strDescription"
    }
}
