//
//  EpisodesResult.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 18.08.21.
//

import Foundation

struct EpisodesResult: Codable {
    let info: ResultInfo
    let episodes: [Episode]
    
    enum CodingKeys: String, CodingKey {
        case info
        case episodes = "results"
    }
}

struct Episode: Codable, Identifiable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters, url
        case airDate = "air_date"
    }
}

struct ResultInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
    
    static let empty = ResultInfo(count: 0, pages: 0, next: nil, prev: nil)
}

extension Episode {
    static let mock = Episode(id: 0, name: "Mock name", airDate: "Mock air date", episode: "Mock Episode", characters: [], url: "")
}
