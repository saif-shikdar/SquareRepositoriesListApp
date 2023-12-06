//
//  RepositoryListView.swift
//  GitHubRepositoriesApp
//
//  Created by Saif Shikdar on 06/12/2023.
//

import SwiftUI

struct RepositoryListView: View {
    @ObservedObject var viewModel: RepositoryViewModel
    
    var body: some View {
        VStack {
            Text("My Repositories")
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
    }
}

#Preview {
    RepositoryListView(viewModel: RepositoryViewModel())
}
