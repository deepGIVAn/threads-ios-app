//
//  CreateThread.swift
//  Threads
//
//  Created by Deepak on 12/07/26.
//

import SwiftUI

struct CreateThreadView: View {
    @StateObject var viewModel = CreateThreadViewModel()
    @State private var caption = ""
    @Environment(\.dismiss) var dismiss
  
    @ObservedObject private var userService = UserService.shared

    private var user: User? {
        userService.currentUser
    }
    
//    private var user: User? {
//        return UserService.shared.currentUser
//    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top) {
                    if let user {
                        CircularProfileImageView(user: user, size: .small)
                    } else {
                        CircularProfileImageView(user: nil, size: .small)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user?.username ?? "")
                            .fontWeight(.semibold)
                        
                        TextField("Start a thread...", text: $caption, axis: .vertical)
                    }
                    .font(.footnote)
                    
                    Spacer()
                    
                    if !caption.isEmpty {
                        Button {
                            caption = ""
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle(Text("New Thread"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundColor(Color.black)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        Task {
                            try await viewModel.uploadThread(caption: caption)
                            dismiss()
                        }
                    }
                    .opacity(caption.isEmpty ? 0.5 : 1)
                    .disabled(caption.isEmpty)
                    .font(.subheadline)
                    .foregroundColor(Color.black)
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    CreateThreadView()
}
