//
//  ExploreView.swift
//  Threads
//
//  Created by Deepak on 12/07/26.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack() {
                    ForEach(0 ... 10, id: \.self) { user in
                        VStack {
                            UserCell()

                            Divider()
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 4)

                    }
                }
            }
            .navigationTitle(Text("Search"))
            .searchable(text: $searchText, prompt: "Search")
        }
    }
}

#Preview {
    ExploreView()
}
