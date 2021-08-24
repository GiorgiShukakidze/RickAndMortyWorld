//
//  CharacterListRow.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 22.08.21.
//

import SwiftUI

struct CharacterListRow: View {
    @State var character: Character
    @State private var image: UIImage?
    
    private var withNavigation: Bool

    init(character: Character, withNavigation: Bool = true) {
        self.character = character
        self.withNavigation = withNavigation
    }
    
    var body: some View {
        NavigatableListView(withNavigation: withNavigation, destination: LazyView(CharacterView(character: character))) {
            listContent
        }
    }
    
    private var listContent: some View {
        HStack {
            AvatarImage(image: $image)
                .frame(width: UIScreen.screenWidth * Constants.imageWidthRatio)
            Spacer()
            VStack(spacing: Constants.detailsSpacing) {
                VStack {
                    Text("Name:").bold()
                    Text(character.name).font(.body)
                }
                VStack {
                    Text("Status:").bold()
                    Text(character.status.rawValue).font(.body).italic()
                }
            }
            Spacer()
        }
        .onAppear {
            UIImage.from(character.image) { uiImage in
                image = uiImage
            }
        }
    }
    
    private enum Constants {
        static let detailsSpacing: CGFloat = 20
        static let imageWidthRatio: CGFloat = 2/5
    }
}

struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListRow(character: .mock)
    }
}
