//
//  Repository.swift
//  GitHubRepositoriesApp
//
//  Created by Saif Shikdar on 06/12/2023.
//

import Foundation
import Combine

protocol RepositoryService {
    func fetchRepos<T: Decodable>(_ type: T.Type, completionHandler: @escaping (Result<RepositorySquare, APIError>) -> Void)
}

class Repository: RepositoryService {
    func fetchRepos<T: Decodable>(_ type: T.Type, completionHandler: @escaping (Result<RepositorySquare, APIError>) -> Void) {
        guard let url = URL(string: Endpoint.url) else {
            let error = APIError.badURL
            completionHandler(Result.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error as? APIError {
                completionHandler(Result.failure(error))
            } else if let response = response as? HTTPURLResponse,
                      !(200...299).contains(response.statusCode) {
                completionHandler(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                do {
                    let repoList = try JSONDecoder().decode(RepositorySquare.self, from: data)
                    completionHandler(Result.success(repoList))
                } catch {
                    completionHandler(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        
        task.resume()
    }
}
