//
//  SingleItemServiceAPIType.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 22.08.21.
//

import Foundation
import Combine

protocol SingleItemServiceAPIType: ServiceAPIType {
    func fetchItem(_ itemId: String) -> AnyPublisher<Request.Response, NetworkError>
}

extension SingleItemServiceAPIType {
    func fetchItem(_ itemId: String) -> AnyPublisher<Request.Response, NetworkError> {

        request.pathQuery = "/\(itemId)"
        
        return serviceManager.fetchResponse(from: request)
    }
}
