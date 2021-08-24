//
//  CharacterDetails.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 22.08.21.
//

import SwiftUI

struct LocationDataView: View {
    @Binding var locationData: (Character.Location, Character.Location)?
    
    var body: some View {
        if let locationData = locationData {
            VStack(alignment: .leading) {
                
            
//            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: Constants.spacing) {
                    HTitleDescriptionText(title: "Origin name:", description: locationData.0.name, font: .body)
                    HTitleDescriptionText(title: "Origin type:", description: locationData.0.type, font: .body)
                    HTitleDescriptionText(title: "Origin dimension:", description: locationData.0.dimension, font: .body)
                }
                .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: Constants.spacing) {
                    HTitleDescriptionText(title: "Location name:", description: locationData.1.name, font: .body)
                    HTitleDescriptionText(title: "Location type:", description: locationData.1.type, font: .body)
                    HTitleDescriptionText(title: "Location dimension:", description: locationData.1.dimension, font: .body)
                }
//            }
            }
        }
    }
    
    private enum Constants {
        static let spacing: CGFloat = 5
    }
}
