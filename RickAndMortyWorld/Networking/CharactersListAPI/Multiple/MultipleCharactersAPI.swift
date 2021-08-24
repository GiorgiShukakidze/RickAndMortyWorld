//
//  MultipleCharactersAPI.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 22.08.21.
//

import Foundation
import Combine

class MultipleCharactersAPI: MultipleItemsServiceAPIType {
    typealias Request = MultipleCharactersRequest
    
    private(set) var serviceManager: APIService
    var request = MultipleCharactersRequest()
    
    init(serviceManager: APIService = NetworkManager.shared) {
        self.serviceManager = serviceManager
    }
}
