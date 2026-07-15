//
//  PreviewProvider.swift
//  Threads
//
//  Created by Deepak on 15/07/26.
//

import Foundation
import SwiftUI
import FirebaseCore

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    let user = User(id: NSUUID().uuidString, fullname: "Deepak Sharma", email: "developer@example.com", username: "deepaksharma")
    
    let thread = Thread(ownerUid: "123", caption: "dummy", timestamp: Timestamp(), likes: 0)
}

