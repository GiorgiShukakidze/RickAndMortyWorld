//
//  LocationAPI.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 22.08.21.
//

import Foundation

class LocationAPI: SingleItemServiceAPIType {
    typealias Request = LocationRequest
    
    private(set) var serviceManager: APIService
    var request = LocationRequest()
    
    init(serviceManager: APIService = NetworkManager.shared) {
        self.serviceManager = serviceManager
    }
}
