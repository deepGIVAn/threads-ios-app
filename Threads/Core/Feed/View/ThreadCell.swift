//
//  ThreadView.swift
//  Threads
//
//  Created by Deepak on 12/07/26.
//

import SwiftUI

struct ThreadCell: View {
    let thread: Thread
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing:12) {

                CircularProfileImageView(user: thread.user, size: .small)

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(thread.user?.username ?? "")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Spacer()
                        Text(thread.timestamp.timestampString())
                            .font(.caption)
                            .foregroundColor(Color(.systemGray2))
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color(.darkGray))
                        }
                        
                    }
                    Text(thread.caption)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                    
                    HStack(spacing: 16) {
                        Button {
                            
                        } label: {
                            Image(systemName: "heart")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "bubble.right")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.rectanglepath")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "paperplane")
                        }
                    }
                    .padding(.vertical, 8)
                    .foregroundStyle(Color(.black))
                }
            }
            Divider()
        }
        .padding()
    }
}

#Preview {
    ThreadCell(thread: DeveloperPreview.shared.thread)
}
