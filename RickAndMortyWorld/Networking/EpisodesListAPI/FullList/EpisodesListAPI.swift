//
//  EpisodesListAPI.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 18.08.21.
//

import Foundation
import Combine

class EpisodesListAPI: ItemsListServiceAPIType {
    typealias Request = EpisodesListRequest
    
    private(set) var serviceManager: APIService
    var request = EpisodesListRequest()
    
    init(serviceManager: APIService = NetworkManager.shared) {
        self.serviceManager = serviceManager
    }
    
    func fetchList(for page: Int? = nil, with filters: [EpisodesQueryItem]? = nil) -> AnyPublisher<EpisodesResult, NetworkError> {
        fetchList(for: page, filteredBy: filters)
    }
}

enum EpisodesQueryItem: FilterType {
    case name(String)
    case episode(String)
    
    var key: String {
        switch self {
        case .name: return "name"
        case .episode: return "episode"
        }
    }
    
    var value: String {
        switch self {
        case .name(let nameValue): return nameValue
        case .episode(let episodeCode): return episodeCode
        }
    }
}
