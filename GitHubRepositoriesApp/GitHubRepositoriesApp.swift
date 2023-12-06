//
//  GitHubRepositoriesApp.swift
//  GitHubRepositoriesApp
//
//  Created by Saif Shikdar on 06/12/2023.
//

import SwiftUI

@main
struct GitHubRepositoriesApp: App {
    var body: some Scene {
        WindowGroup {
            RepositoryListView(viewModel: RepositoryViewModel())
        }
    }
}
