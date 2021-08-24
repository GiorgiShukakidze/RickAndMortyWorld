//
//  EpisodeViewModel.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 19.08.21.
//

import SwiftUI
import Combine

class EpisodeViewModel: ObservableObject {
    @Published var episode: Episode
    @Published var characters: [Character] = []
    @Published private(set) var state: ViewModelState = .idle
    @Published var showError: Bool = false
    @Published var characterName = ""

    private(set) var errorMessage: String = ""
    
    private let multipleCharactersListService = MultipleCharactersAPI()
    private lazy var cancellables = Set<AnyCancellable>()
    private var allCharacters: CurrentValueSubject<[Character], Never> = .init([])

    private var currentQuery = ""
    
    init(episode: Episode) {
        self.episode = episode
        setupBindings()
    }
    
    deinit {
        print(String(describing: self), "Deinitialized")
    }

    func fetchCharacters() {
        state = .loading
        
        multipleCharactersListService.fetchMultiple(items: getCharactersList())
            .catch {[weak self] error -> AnyPublisher<[Character], Never> in
                self?.state = .error
                self?.showError = true
                self?.errorMessage = error.description
                
                return .init(Empty())
            }
            .sink {[weak self] characters in
                self?.handleData(characters)
            }
            .store(in: &cancellables)
    }
    
    func invalidate() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    private func setupBindings() {
        allCharacters
            .map {[weak self] characters in
                characters.filter({ $0.name.hasPrefix(self?.currentQuery ?? "") })
            }
            .assign(to: &$characters)
        
        $characterName
            .dropFirst()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink {[weak self] characterName in
                self?.filterList(with: characterName)
            }
            .store(in: &cancellables)
    }
    
    private func filterList(with characterName: String) {
        currentQuery = characterName
        characters = allCharacters.value.filter { $0.name.hasPrefix(characterName) }
    }
    
    private func getCharactersList() -> [String] {
        var charactersList = [String]()
        episode.characters.forEach { charactersList.append(String($0.components(separatedBy: "/").last!)) }
        
        return charactersList
    }
    
    private func handleData(_ charactersList: [Character]) {
        allCharacters.send(charactersList)
        state = charactersList.isEmpty ? .empty : .complete
    }
}
