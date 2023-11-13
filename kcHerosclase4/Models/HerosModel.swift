//
//  HerosMode.swift
//  kcHerosclase4
//
//  Created by ibautista on 6/11/23.
//

import Foundation

struct Heros: Codable, Identifiable{
    var id: UUID
    var name: String
    var description: String
    var photo: String //url
    var favorite: Bool?
    
    func getFullName() -> String {
        return "BB \(name)"
    }
}

//Para la request, necesito el nombre del heroe

struct HeroFilter: Codable {
    var name: String
}
