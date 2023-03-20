//
//  AreasTagList.swift
//  MakeSomeFood
//
//  Created by Луиза Самойленко on 20.03.2023.
//

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
