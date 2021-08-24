//
//  ViewModifiers.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 22.08.21.
//

import Foundation
import SwiftUI

struct FetchErrorAlert: ViewModifier {
    @Binding var isPresented: Bool
    @State var message: String
    @State var title: String
    
    init(isPresented: Binding<Bool>, message: String, title: String = Constants.StaticTexts.fetchErrorMessage) {
        self._isPresented = isPresented
        self.message = message
        self.title = title
    }
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: $isPresented) {
                Alert(title: Text(title), message: Text(message))
            }
    }
}
