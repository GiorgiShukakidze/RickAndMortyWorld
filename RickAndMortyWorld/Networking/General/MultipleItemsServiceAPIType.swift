//
//  MultipleItemsServiceAPIType.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 22.08.21.
//

import Foundation
import Combine

protocol MultipleItemsServiceAPIType: ServiceAPIType {
    func fetchMultiple(for page: Int?, items: [String]) -> AnyPublisher<Request.Response, NetworkError>
}

extension MultipleItemsServiceAPIType {
    func fetchMultiple(for page: Int? = nil, items: [String]) -> AnyPublisher<Request.Response, NetworkError> {
        if let page = page {
            request.queryItems = [
                URLQueryItem(name: "page", value: String(page)),
            ]
        }
        let itemsParameter = items.joined(separator: ",")
        request.pathQuery = "/[\(itemsParameter)]"
        
        return serviceManager.fetchResponse(from: request)
    }
}
