//
//  CurrentUserProfileView.swift
//  Threads
//
//  Created by Deepak on 15/07/26.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @StateObject var viewModel = CurrentUserProfileViewModel()
    @State private var selectedFilter: ProfileThreadFilter = .threads
    
    private var currentUser: User? {
        return viewModel.currentUser
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                // bio and stats
                VStack(spacing: 20) {

                    ProfileHeaderView(user: currentUser)

                    Button {

                    } label: {
                        Text("Follow")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.white))
                            .frame(width: 352, height: 32)
                            .background(Color(.black))
                            .cornerRadius(10)
                    }

                    // user content list view
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
                                ThreadCell()
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .padding(.horizontal)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        do {
                            try AuthService.shared.signOut()
                        } catch {
                            // TODO: Present an alert/toast to the user
                            print("Sign out failed: \(error)")
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
            }
        }
    }
}

#Preview {
    CurrentUserProfileView()
}
