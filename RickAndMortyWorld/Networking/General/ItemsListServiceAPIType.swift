//
//  ItemsListServiceAPIType.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 19.08.21.
//

import Foundation
import Combine

protocol ItemsListServiceAPIType: ServiceAPIType {    
    func fetchList(for page: Int?, filteredBy filters: [FilterType]?) -> AnyPublisher<Request.Response, NetworkError>
}

extension ItemsListServiceAPIType {
    func fetchList(for page: Int? = nil, filteredBy filters: [FilterType]? = nil) -> AnyPublisher<Request.Response, NetworkError> {
        var queryItems = [URLQueryItem]()
        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
        }
        
        if let filterItems = filters {
            filterItems.forEach { queryItems.append(URLQueryItem(name: $0.key, value: $0.value)) }
        }
        
        request.queryItems = queryItems
        
        return serviceManager.fetchResponse(from: request)
    }
}

protocol FilterType {
    var key: String { get }
    var value: String { get }
}
