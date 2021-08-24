//
//  RequestType.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 18.08.21.
//

import Foundation

protocol RequestType {
    associatedtype Response: Codable
    
    var baseURLString: String { get set }
    var pathString: String { get set }
    var pathQuery: String { get set }
    var queryItems: [URLQueryItem]? { get set }
    var headerParameters: [String : String]? { get set }
    
    func request() -> URLRequest?
}

extension RequestType {
    var queryItems: [URLQueryItem]? { nil }
    var headerParameters: [String : String]? { nil }
    var baseURL: URL? { URL(string: baseURLString)}
    var pathQuery: String { "" }

    var fullUrl: URL? { URL(string: pathString + pathQuery, relativeTo: baseURL)}
    
    func request() -> URLRequest? {
        guard let fullURL = fullUrl else { return nil }
        
        var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        
        if let components = components,
           let url = components.url {
            var urlRequest = URLRequest(url: url)
            
            if let headerParameters = headerParameters {
                for (key, value) in headerParameters {
                    urlRequest.addValue(value, forHTTPHeaderField: key)
                }
            }
            
            return urlRequest
        }
        
        return nil
    }
}
