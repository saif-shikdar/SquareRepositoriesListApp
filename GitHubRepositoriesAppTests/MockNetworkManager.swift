//
//  MockNetworkManager.swift
//  GitHubRepositoriesAppTests
//
//  Created by Saif Shikdar on 03/01/2024.
//

import Foundation
@testable import GitHubRepositoriesApp

class MockNetworkManager: NetworkService {
    func fetchRepos<T>(_ type: T.Type, completionHandler: @escaping (Result<RepositorySquare, APIError>) -> Void) where T : Decodable {
        let bundle = Bundle(for: MockNetworkManager.self)
        let url = bundle.url(forResource: "SquareRepositories", withExtension: "json")
        guard let url = url else { return completionHandler(Result.failure(APIError.badURL)) }
        do {
            let rawData =  try Data(contentsOf: url)
            let result = try JSONDecoder().decode(T.self, from: rawData)
            print(result)
            completionHandler(Result.success((result as? RepositorySquare)!))
        } catch {
            completionHandler(Result.failure(APIError.unknown))
        }
    }
}
