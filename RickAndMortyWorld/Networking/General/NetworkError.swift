//
//  NetworkError.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 23.08.21.
//

import Foundation

enum NetworkError: Error {
    case invalidURLRequest
    case responseError
    case serverError
    case parseError
    
    var description: String {
        switch self {
        case .invalidURLRequest, .parseError, .serverError: return "Oops...\nSomething went wrong.\nTry again."
        case .responseError: return "Oops...\nNothing to show.\nTry again."
        }
    }
}
