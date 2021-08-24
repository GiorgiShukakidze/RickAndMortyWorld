//
//  EpisodesListRequest.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 18.08.21.
//

import Foundation

class EpisodesListRequest: RequestType {
    typealias Response = EpisodesResult

    var baseURLString: String = URLRepository.baseURL
    var pathString: String = URLRepository.episodesPath
    var pathQuery: String = ""
    var queryItems: [URLQueryItem]?
    var headerParameters: [String : String]?
}
