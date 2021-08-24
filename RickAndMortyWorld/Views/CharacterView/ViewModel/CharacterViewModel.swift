//
//  CharacterViewModel.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 22.08.21.
//

import Foundation
import Combine

class CharacterViewModel: ObservableObject {
    @Published var character: Character
    @Published var episodes: [Episode] = []
    @Published private(set) var state: ViewModelState = .idle
    @Published var showError: Bool = false
    @Published var locationData: (Character.Location, Character.Location)?
    @Published var episodeName = ""
    
    private(set) var errorMessage: String = ""
    
    private let multipleEpisodesListService = MultipleEpisodesAPI()
    private let locationAPIService = LocationAPI()
    private lazy var cancellables = Set<AnyCancellable>()
    private var allEpisodes: CurrentValueSubject<[Episode], Never> = .init([])

    private var currentQuery = ""
    
    init(character: Character) {
        self.character = character
        setupBindings()
    }
    
    deinit {
        print(String(describing: self), "Deinitialized")
    }

    func fetchEpisodes() {
        state = .loading
        
        let originPublisher = originDataPublisher()
        let locationPublisher = locationDataPublisher()
        let episodesPublisher = multipleEpisodesListService.fetchMultiple(items: getEpisodesList())
            .catch {[weak self] error -> AnyPublisher<[Episode], Never> in
                self?.state = .error
                self?.showError = true
                self?.errorMessage = error.description
                
                return .init(Empty())
            }
            .eraseToAnyPublisher()
        
        originPublisher
            .zip(locationPublisher, episodesPublisher)
            .sink {[weak self] data in self?.handleData(data) }
            .store(in: &cancellables)
    }
    
    func invalidate() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    private func setupBindings() {
        allEpisodes
            .map {[weak self] episodes in
                episodes.filter({ $0.name.hasPrefix(self?.currentQuery ?? "") })
            }
            .assign(to: &$episodes)
        
        $episodeName
            .dropFirst()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink {[weak self] episodeName in
                self?.filterList(with: episodeName)
            }
            .store(in: &cancellables)
    }

    private func originDataPublisher() -> AnyPublisher<Character.Location, Never> {
        let current = Character.Location.init(name: character.origin.name,
                                              url: character.origin.url)
        
        guard let id = character.origin.url.components(separatedBy: "/").last,
              !id.isEmpty else { return Just(current).eraseToAnyPublisher() }
        
        return locationAPIService.fetchItem(String(id))
            .replaceError(with: current)
            .eraseToAnyPublisher()
    }
    
    private func locationDataPublisher() -> AnyPublisher<Character.Location, Never> {
        let current = Character.Location.init(name: character.location.name,
                                              url: character.location.url)
        
        guard let id = character.location.url.components(separatedBy: "/").last,
              !id.isEmpty else { return Just(current).eraseToAnyPublisher() }
        
        return locationAPIService.fetchItem(String(id))
            .replaceError(with: current)
            .eraseToAnyPublisher()
    }
    
    private func filterList(with episodeName: String) {
        currentQuery = episodeName
        episodes = allEpisodes.value.filter { $0.name.hasPrefix(episodeName) }
    }
    
    private func getEpisodesList() -> [String] {
        var episodesList = [String]()
        character.episode.forEach { episodesList.append(String($0.components(separatedBy: "/").last!)) }
        
        return episodesList
    }
    
    private func handleData(_ data: (origin: Character.Location, location: Character.Location, episodes: [Episode])) {
        locationData = (data.origin, data.location)
        allEpisodes.send(data.episodes)
        state = data.episodes.isEmpty ? .empty : .complete
    }
}
