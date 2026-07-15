//
//  CicularProfileImageVIew.swift
//  Threads
//
//  Created by Deepak on 12/07/26.
//

import SwiftUI

struct CircularProfileImageView: View {
    var body: some View {
        Image("tiger")
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}

#Preview {
    CircularProfileImageView()
}
