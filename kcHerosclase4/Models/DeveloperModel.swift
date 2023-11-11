//
//  VieModelHeroes.swift
//  kcHerosclase4
//
//  Created by ibautista on 6/11/23.
//

import Foundation
struct Bootcamp: Codable, Identifiable {
    let id, name: String
}

struct DeveloperModel: Codable, Identifiable{
    let apell1, apell2: String
    let id, email: String
    let photo: String
    let name: String
    let bootcamp: Bootcamp
    let heros: [Heros]
}
