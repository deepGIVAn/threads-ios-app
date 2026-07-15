//
//  UserCell.swift
//  Threads
//
//  Created by Deepak on 12/07/26.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack() {
            CircularProfileImageView()
                                            
            VStack(alignment: .leading) {
                Text("Deepak")
                    .fontWeight(.semibold)
                
                Text("Deepak Sharma")
            }
            .font(.footnote)
            
            Spacer()
            
            Text("Follow")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 100, height: 32)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
        }
        .padding(.horizontal)
    }
}

#Preview {
    UserCell()
}
