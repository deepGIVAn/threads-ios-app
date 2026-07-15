//
//  ExploreView.swift
//  Threads
//
//  Created by Deepak on 12/07/26.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText: String = ""
    @StateObject var viewModel = ExploreViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack() {
                    ForEach(viewModel.users) { user in
                        NavigationLink(value: user) {
                            VStack {
                                UserCell(user: user)
                                Divider()
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .navigationTitle(Text("Search"))
            .searchable(text: $searchText, prompt: "Search")
        }
    }
}

#Preview {
    ExploreView()
}
