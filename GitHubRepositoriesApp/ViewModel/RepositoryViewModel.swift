//
//  RepositoryViewModel.swift
//  GitHubRepositoriesApp
//
//  Created by Saif Shikdar on 06/12/2023.
//

import Foundation
import Combine

protocol RepositoryViewModelling {
    func getRepoList()
}

class RepositoryViewModel: ObservableObject {
    var subscriptions: Set<AnyCancellable> = []
    let repository: RepositoryService
    
    @Published var repoList: RepositorySquare?
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    init(repository: RepositoryService = Repository()) {
        self.repository = repository
        getRepoList()
    }
}

extension RepositoryViewModel: RepositoryViewModelling {
    func getRepoList() {
        isLoading = true
        repository.fetchRepos(RepositorySquare.self) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let repoList):
                    self.repoList = repoList
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error)
                }
            }
        }
    }
}

