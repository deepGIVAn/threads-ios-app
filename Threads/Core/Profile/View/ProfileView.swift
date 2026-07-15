//
//  ProfileView.swift
//  Threads
//
//  Created by Deepak on 12/07/26.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace var animation
    
    private var currentUser: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                let rawWidth = proxy.size.width / CGFloat(ProfileThreadFilter.allCases.count) - 16
                let filterBarWidth = max(0, rawWidth.isFinite ? rawWidth : 0)
                ScrollView(showsIndicators: false) {
                    // bio and stats
                    VStack(spacing: 20) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 12) {
                                // fullname and username
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(currentUser?.fullname ?? "dummy")
                                        .font(.title2)
                                        .fontWeight(.semibold)

                                    Text(currentUser?.username ?? "dummy")
                                        .font(.subheadline)
                                }

                                if let bio = currentUser?.bio {
                                    Text(bio)
                                        .font(.footnote)
                                }
                                
                                Text("2 followers")
                                    .font(.caption)
                                    .foregroundStyle(Color(.gray))
                            }
                            
                            Spacer()
                            
                            CircularProfileImageView()
                        }

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
                                    VStack {
                                        Text(filter.title)
                                            .font(.subheadline)
                                            .fontWeight(selectedFilter == filter ? .semibold : .regular)

                                        Rectangle()
                                            .foregroundColor(selectedFilter == filter ? Color(.black) : Color(.clear))
                                            .frame(width: filterBarWidth, height: 1)
                                            .matchedGeometryEffect(id: "filterIndicator", in: animation)
                                    }
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
            }
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
    ProfileView()
}

