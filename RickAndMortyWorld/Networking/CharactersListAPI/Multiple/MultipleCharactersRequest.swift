//
//  MultipleCharactersRequest.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 22.08.21.
//

import Foundation

class MultipleCharactersRequest: RequestType {
    typealias Response = [Character]

    var baseURLString: String = URLRepository.baseURL
    var pathString: String = URLRepository.characterPath
    var pathQuery: String = ""
    var queryItems: [URLQueryItem]?
    var headerParameters: [String : String]?
}
