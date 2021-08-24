//
//  ServiceAPIType.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 22.08.21.
//

import Foundation
import Combine

protocol ServiceAPIType: AnyObject {
    associatedtype Request: RequestType
    
    var serviceManager: APIService { get }
    var request: Request { get set }    
}
