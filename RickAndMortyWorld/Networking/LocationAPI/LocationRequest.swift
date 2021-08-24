//
//  LocationListRequest.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 22.08.21.
//

import Foundation

class LocationRequest: RequestType {
    typealias Response = Character.Location

    var baseURLString: String = URLRepository.baseURL
    var pathString: String = URLRepository.locationPath
    var pathQuery: String = ""
    var queryItems: [URLQueryItem]?
    var headerParameters: [String : String]?
}
