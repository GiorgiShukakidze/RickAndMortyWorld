//
//  ContentView.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 18.08.21.
//

import SwiftUI

struct EpisodesListView: View {
    @ObservedObject var viewModel = EpisodesListViewModel()
    
    @State var isLoading = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    SearchBarView(searchText: $viewModel.episodeName, placeholder: "Enter episode name")
                    List {
                        ForEach(viewModel.episodes, id: \.id) { episode in
                            EpisodesListRow(episode: episode)
                                .padding(.vertical, 15)
                        }
                        
                        if viewModel.hasMore {
                            LoadingMoreCell()
                                .onAppear { viewModel.fetchNextPage() }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                
                if viewModel.state == .error {
                    RetryButton(refreshAction: viewModel.refresh)
                }
                
                if viewModel.state == .loading {
                    ProgressView().scaleEffect(2)
                }
                
                if viewModel.state == .empty {
                    Text("No items to show...")
                }
            }
            .navigationBarTitle("Episodes List")
        }
        .onChange(of: viewModel.state) { isLoading = $0 == .loading }
        .overlay(LoadingOverlay(show: $isLoading))
        .onAppear {
            setupNavigationBar()
            viewModel.fetchEpisodes()
        }
        .fetchErrorAlert(isPresented: $viewModel.showError, message: viewModel.errorMessage)
    }
    
    private func setupNavigationBar() {
        let color = UIColor(named: "RickColor") ?? .green
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: color]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: color]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesListView()
    }
}
