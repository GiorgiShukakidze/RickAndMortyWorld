//
//  Character.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 18.08.21.
//

import Foundation

struct CharactersResult: Codable {
    let info: ResultInfo
    let characters: [Character]
    
    enum CodingKeys: String, CodingKey {
        case info
        case characters = "results"
    }
}

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let status: Status
    let type: String
    let gender: Gender
    var origin: Location
    var location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    enum Gender: String, Codable {
        case female = "Female"
        case male = "Male"
        case unknown = "unknown"
        case genderless = "Genderless"
    }

    struct Location: Codable {
        let name: String
        let url: String
        let type: String
        let dimension: String
        
        enum CodingKeys: String, CodingKey {
            case name, url, type, dimension
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            name = try container.decode(String.self, forKey: .name)
            url = try container.decode(String.self, forKey: .url)
            type = (try? container.decode(String.self, forKey: .type)) ?? ""
            dimension = (try? container.decode(String.self, forKey: .dimension)) ?? ""
        }
        
        init(name: String, url: String, type: String = "", dimension: String = ""){
            self.name = name
            self.url = url
            self.type = type
            self.dimension = dimension
        }
    }

    enum Status: String, Codable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }
}

extension Character {
    static let mock = Character(
        id: 0,
        name: "Mock name",
        status: .unknown,
        type: "Mock type",
        gender: .unknown,
        origin: .init(name: "", url: ""),
        location: .init(name: "", url: ""),
        image: "",
        episode: [],
        url: "",
        created: ""
    )
}
