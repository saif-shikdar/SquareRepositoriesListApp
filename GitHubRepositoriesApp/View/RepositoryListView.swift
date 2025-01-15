//
//  RepositoryListView.swift
//  GitHubRepositoriesApp
//
//  Created by Saif Shikdar on 06/12/2023.
//

import SwiftUI

struct RepositoryListView: View {
    @StateObject var viewModel: RepositoryViewModel = RepositoryViewModel(network: 
        NetworkManager(urlSession: URLSession.shared))
    
    var body: some View {
        VStack {
            Text("Square Repositories")
                .font(.title)
            Spacer()
            if viewModel.isLoading {
                ProgressView()
                    .controlSize(.large)
            } else {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(viewModel.repoList ?? [], id: \.id) { repo in
                            RepositoryCardView(fullName: repo.name ?? "",
                                               description: repo.description ?? "-",
                                               watchers: "\(repo.watchers ?? 0)")
                            Divider()
                        }
                    }
                }
            }
            Spacer()
        }
        .padding()
        .task {
            viewModel.getRepoList()
        }
    }
}

#Preview {
    RepositoryListView()
}
