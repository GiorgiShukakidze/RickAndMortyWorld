//
//  MultipleEpisodesRequest.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 22.08.21.
//

import Foundation

class MultipleEpisodesRequest: RequestType {
    typealias Response = [Episode]

    var baseURLString: String = URLRepository.baseURL
    var pathString: String = URLRepository.episodesPath
    var pathQuery: String = ""
    var queryItems: [URLQueryItem]?
    var headerParameters: [String : String]?
}
