//
//  EpisodesListRow.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 18.08.21.
//

import SwiftUI

struct EpisodesListRow: View {
    @State var episode: Episode
    
    private var withNavigation: Bool
    
    init(episode: Episode, withNavigation: Bool = true) {
        self.episode = episode
        self.withNavigation = withNavigation
    }
    
    var body: some View {
        NavigatableListView(withNavigation: withNavigation, destination: LazyView(EpisodeView(episode: episode))) {
            episodeDetails
        }
    }
    
    var episodeDetails: some View {
        VStack(alignment: .leading, spacing: Constants.detailsSpacing) {
            HTitleDescriptionText(title: "Name: ", description: "\(episode.name)", alignment: .centered)
            HTitleDescriptionText(title: "Episode: ", description: "\(episode.episode)", alignment: .centered)
            HTitleDescriptionText(title: "Air Date: ", description: "\(episode.airDate)", font: .body.italic(), alignment: .centered)
        }
    }
    
    private enum Constants {
        static let detailsSpacing: CGFloat = 10
    }
}
