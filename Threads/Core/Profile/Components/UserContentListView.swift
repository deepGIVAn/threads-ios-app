//
//  UserContentListView.swift
//  Threads
//
//  Created by Deepak on 15/07/26.
//

import SwiftUI

struct UserContentListView: View {
    @State private var selectedFilter: ProfileThreadFilter = .threads

    var body: some View {
        VStack {
            HStack {
                ForEach(ProfileThreadFilter.allCases) { filter in
                    VStack(spacing: 6) {
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter == filter ? .semibold : .regular)
                            .frame(maxWidth: .infinity)
                        Rectangle()
                            .foregroundColor(selectedFilter == filter ? Color(.black) : Color(.clear))
                            .frame(height: 1)
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedFilter = filter
                        }
                    }
                }
            }

            LazyVStack {
                ForEach (0 ... 10, id: \.self) { _ in
//                    ThreadCell(thread: nil) 
                }
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    UserContentListView()
}
