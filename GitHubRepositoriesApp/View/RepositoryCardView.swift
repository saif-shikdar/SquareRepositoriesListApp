//
//  RepositoryCardView.swift
//  GitHubRepositoriesApp
//
//  Created by Saif Shikdar on 06/12/2023.
//

import SwiftUI

struct RepositoryCardView: View {
    let fullName: String
    let description: String
    let userAvatar: String
    
    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 15) {
                Text(fullName)
                    .fontWeight(.semibold)
                Text(description)
                    .fontWeight(.light)
            }
            Spacer()
            AsyncImage(url: URL(string: userAvatar)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(maxWidth: 50, maxHeight: 50)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    // Since the AsyncImagePhase enum isn't frozen,
                    // we need to add this currently unused fallback
                    // to handle any new cases that might be added
                    // in the future:
                    EmptyView()
                }
            }
        }
        .padding(16)
        .frame(height: 120)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 1)
        )
        .padding(.vertical, 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryCardView(fullName: "square/yajl-objc", 
                           description: "Objective-C bindings for YAJL (Yet Another JSON Library) C library",
                           userAvatar: "https://avatars.githubusercontent.com/u/82592?v=4")
            .previewLayout(.sizeThatFits)

    }
}
