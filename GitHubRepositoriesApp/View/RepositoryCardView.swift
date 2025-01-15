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
    let watchers: String
    
    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 15) {
                Text(fullName)
                    .fontWeight(.semibold)
                Text(description)
                    .fontWeight(.light)
                    .frame(maxWidth: 260, alignment: .leading)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 25) {
                AsyncImage(url: URL(string: "https://avatars.githubusercontent.com/u/82592?v=4")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(maxWidth: 30, maxHeight: 30)
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
                HStack {
                    Image(systemName: "heart.fill")
                    Text(watchers)
                        .fontWeight(.light)
                }
                
            }
            
        }
        .padding(16)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryCardView(fullName: "square/yajl-objc", 
                           description: "Objective-C bindings for YAJL (Yet Another JSON Library) C library",
                           watchers: "0")
            .previewLayout(.sizeThatFits)

    }
}
