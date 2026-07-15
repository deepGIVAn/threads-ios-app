//
//  CurrentUserProfileView.swift
//  Threads
//
//  Created by Deepak on 15/07/26.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @StateObject var viewModel = CurrentUserProfileViewModel()
    @State private var showEditProfile = false
    
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
                        showEditProfile.toggle()
                    } label: {
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.black))
                            .frame(width: 352, height: 32)
                            .background(Color(.white))
                            .cornerRadius(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            }
                    }

                    // user content list view
                    UserContentListView()
                }
            }
            .sheet(
                isPresented: $showEditProfile, content: {
                    if let user = currentUser {
                        EditProfileView(user: user)
                        //    .environmentObject(viewModel)
                    }
                }
            )
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
