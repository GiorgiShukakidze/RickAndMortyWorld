//
//  NetworkManager.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 18.08.21.
//

import Foundation
import Combine

class NetworkManager: APIService {
    static let shared = NetworkManager()
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchResponse<Request: RequestType>(from request: Request) -> AnyPublisher<Request.Response, NetworkError> {
        guard let urlRequest = request.request() else {
            return Fail(error: NetworkError.invalidURLRequest).eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        
        print("Starting request for: ", urlRequest.url?.absoluteString ?? "")
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .receive(on: RunLoop.main)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      200 == httpResponse.statusCode else {
                    let responseCode = (response as! HTTPURLResponse).statusCode
                    switch responseCode {
                    case 400...499:
                        throw NetworkError.responseError
                    default:
                        throw NetworkError.serverError
                    }
                }
                
                return data
            }
            .decode(type: Request.Response.self, decoder: decoder)
            .mapError { error in error is NetworkError ? error as! NetworkError :  NetworkError.parseError }
            .eraseToAnyPublisher()
    }
}
