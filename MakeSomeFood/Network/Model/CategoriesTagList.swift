//
//  CategoriesTagList.swift
//  MakeSomeFood
//
//  Created by Луиза Самойленко on 20.03.2023.
//

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
