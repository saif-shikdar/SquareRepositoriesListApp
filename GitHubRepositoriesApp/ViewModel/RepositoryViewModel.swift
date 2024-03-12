//
//  RepositoryViewModel.swift
//  GitHubRepositoriesApp
//
//  Created by Saif Shikdar on 06/12/2023.
//

import Foundation

protocol RepositoryViewModelling {
    func getRepoList()
}

class RepositoryViewModel: ObservableObject {
    let networkService: NetworkService
    
    @Published var repoList: RepositorySquare?
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    init(network: NetworkService = NetworkManager()) {
        self.networkService = network
    }
}

extension RepositoryViewModel: RepositoryViewModelling {
    
    func getRepoList() {
        DispatchQueue.main.async {
            self.isLoading = true
            self.networkService.fetchRepos(RepositorySquare.self) { result in
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
}

