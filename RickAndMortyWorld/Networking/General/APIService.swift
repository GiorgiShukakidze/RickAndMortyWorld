//
//  ServiceType.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 18.08.21.
//

import Combine

protocol APIService {
    func fetchResponse<Request: RequestType>(from request: Request) -> AnyPublisher<Request.Response, NetworkError>
}
