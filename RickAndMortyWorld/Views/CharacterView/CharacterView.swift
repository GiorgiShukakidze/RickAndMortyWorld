//
//  CharacterView.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 22.08.21.
//

import SwiftUI

struct CharacterView: View {
    @ObservedObject var viewModel: CharacterViewModel
    
    @State var isLoading = false
    
    init(character: Character) {
        viewModel = .init(character: character)
    }
    
    var body: some View {
        VStack {
            SearchBarView(searchText: $viewModel.episodeName, placeholder: "Enter episode name")
                .padding(.bottom, 10)
            VStack {
                CharacterListRow(character: viewModel.character, withNavigation: false)
                LocationDataView(locationData: $viewModel.locationData)
            }
            .padding(.horizontal, Constants.verticalPadding)
            Color(.gray)
                .frame(width: UIScreen.screenWidth * 0.7, height: 1)
            ZStack {
                List {
                    ForEach(viewModel.episodes, id: \.id) { episode in
                        EpisodesListRow(episode: episode)
                    }
                }
                .listStyle(PlainListStyle())

                if viewModel.state == .loading {
                    ProgressView().scaleEffect(2)
                }
            }
        }
        .navigationBarItems(trailing: PopToRootButton())
        .navigationBarTitle(Text("Character"), displayMode: .automatic)
        .onChange(of: viewModel.state) { isLoading = $0 == .loading }
        .onAppear { viewModel.fetchEpisodes() }
        .onDisappear { viewModel.invalidate() }
        .overlay(LoadingOverlay(show: $isLoading))
        .fetchErrorAlert(isPresented: $viewModel.showError, message: viewModel.errorMessage)
    }
    
    private enum Constants {
        static let verticalPadding: CGFloat = 15
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(character: .mock)
    }
}
