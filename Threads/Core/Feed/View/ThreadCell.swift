//
//  ThreadView.swift
//  Threads
//
//  Created by Deepak on 12/07/26.
//

import SwiftUI

struct ThreadCell: View {
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing:12) {

                CircularProfileImageView()

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Deepak")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Spacer()
                        Text("10m")
                            .font(.caption)
                            .foregroundColor(Color(.systemGray2))
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color(.darkGray))
                        }
                        
                    }
                    Text("Thread Capption")
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
    ThreadCell()
}
