//
//  EpisodeView.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 18.08.21.
//

import SwiftUI

struct EpisodeView: View {
    @ObservedObject var viewModel: EpisodeViewModel
        
    @State var isLoading = false
    
    init(episode: Episode) {
        viewModel = .init(episode: episode)
    }
    
    var body: some View {
        VStack {
            SearchBarView(searchText: $viewModel.characterName, placeholder: "Enter character name")
                .padding(.bottom, 10)
            EpisodesListRow(episode: viewModel.episode, withNavigation: false)
            ZStack {
                List {
                    ForEach(viewModel.characters, id: \.id) { character in
                        CharacterListRow(character: character)
                    }
                }
                .listStyle(PlainListStyle())
                
                if viewModel.state == .loading {
                    ProgressView().scaleEffect(2)
                }
            }
        }
        .onDisappear { viewModel.invalidate() }
        .navigationBarItems(trailing: PopToRootButton())
        .navigationBarTitle(Text("Episode"), displayMode: .automatic)
        .onChange(of: viewModel.state) { isLoading = $0 == .loading }
        .onAppear { viewModel.fetchCharacters() }
        .overlay(LoadingOverlay(show: $isLoading))
        .fetchErrorAlert(isPresented: $viewModel.showError, message: viewModel.errorMessage)
    }
}

struct EpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeView(episode: .mock)
    }
}
