//
//  EpisodesListViewModel.swift
//  RickAndMortyWorld
//
//  Created by Giorgi Shukakidze on 18.08.21.
//

import Foundation
import Combine

class EpisodesListViewModel: ObservableObject {
    @Published private(set) var episodes = [Episode]()
    @Published private(set) var state: ViewModelState = .idle
    @Published var showError: Bool = false
    @Published var episodeName = ""

    var hasMore: Bool { currentPage < episodesInfo.pages}
    private(set) var errorMessage: String = ""
    
    private var episodesInfo: ResultInfo = .empty
    private lazy var currentPage = 1
    private lazy var currentQuery: [EpisodesQueryItem] = []
    private lazy var cancellables = Set<AnyCancellable>()
    private let episodesListService = EpisodesListAPI()
    
    init() {
        setupBindings()
    }

    deinit {
        print(String(describing: self), "Deinitialized")
    }
    
    func fetchEpisodes(with filters: [EpisodesQueryItem]? = nil) {
        state = .loading
        
        let episodesPublisher = episodesListService.fetchList(for: currentPage, with: filters ?? currentQuery)
            .catch {[weak self] error -> AnyPublisher<EpisodesResult, Never> in
                self?.state = .error
                self?.showError = true
                self?.errorMessage = error.description
                
                return .init(Empty())
            }
            .share()
        
        episodesPublisher
            .map(\.info)
            .assign(to: \.episodesInfo, on: self)
            .store(in: &cancellables)
        
        episodesPublisher
            .map(\.episodes)
            .sink {[weak self] episodes in
                self?.handleData(episodes)
            }
            .store(in: &cancellables)
    }
    
    func fetchNextPage() {
        guard state == .complete && hasMore else { return }
        
        currentPage += 1
        fetchEpisodes()
    }
    
    func refresh() {
        reset()
        fetchEpisodes()
    }
    
    private func setupBindings() {
        $episodeName
            .dropFirst()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink {[weak self] episodeName in
                self?.filterEpisodes(with: episodeName)
            }
            .store(in: &cancellables)
    }
    
    private func filterEpisodes(with name: String) {
        reset()
        
        if name.isEmpty {
            currentQuery.removeAll()
        } else {
            currentQuery = [EpisodesQueryItem.name(name)]
        }
        
        fetchEpisodes()
    }
    
    private func handleData(_ episodesList: [Episode]) {
        if episodesList.isEmpty && currentPage == 1 {
            state = .empty
            episodes = []
        } else {
            state = .complete
            episodes += episodesList
        }
    }
    
    private func reset() {
        currentPage = 1
        episodes = []
        episodesInfo = .empty
        state = .idle
    }
}
