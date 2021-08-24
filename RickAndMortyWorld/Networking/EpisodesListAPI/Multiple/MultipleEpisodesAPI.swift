//
//  MultipleEpisodesAPI.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 22.08.21.
//

import Foundation
import Combine

class MultipleEpisodesAPI: MultipleItemsServiceAPIType {
    typealias Request = MultipleEpisodesRequest
    
    private(set) var serviceManager: APIService
    var request = MultipleEpisodesRequest()
    
    init(serviceManager: APIService = NetworkManager.shared) {
        self.serviceManager = serviceManager
    }
}

