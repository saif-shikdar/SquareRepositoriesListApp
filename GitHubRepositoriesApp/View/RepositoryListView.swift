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
                .padding(.bottom, 15)
            Spacer()
            if viewModel.isLoading {
                ProgressView()
                    .controlSize(.large)
            } else {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(viewModel.repoList ?? [], id: \.id) { repo in
                            RepositoryCardView(fullName: repo.fullName ?? "", 
                                               description: repo.description ?? "",
                                               userAvatar: repo.owner?.avatarURL ?? "")
                        }
                    }
                }
            }
            Spacer()
        }
        .padding()
        .task {
            await viewModel.getRepoList()
        }
    }
}

#Preview {
    RepositoryListView()
}
