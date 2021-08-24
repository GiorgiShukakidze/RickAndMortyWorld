//
//  ViewModelState.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 24.08.21.
//

import Foundation

enum ViewModelState: Equatable {
    case idle
    case loading
    case complete
    case empty
    case error
}
