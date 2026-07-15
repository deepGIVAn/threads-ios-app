//
//  ProfileView.swift
//  Threads
//
//  Created by Deepak on 12/07/26.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    @State private var selectedFilter: ProfileThreadFilter = .threads
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                // bio and stats
                VStack(spacing: 20) {
                    ProfileHeaderView(user: user)

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
                    UserContentListView()
                }
            }
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileView(user: DeveloperPreview.shared.user)
}
