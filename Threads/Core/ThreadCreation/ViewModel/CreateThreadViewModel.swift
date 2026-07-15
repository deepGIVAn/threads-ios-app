//
//  CreateThreadViewModel.swift
//  Threads
//
//  Created by Deepak on 15/07/26.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import Combine
import FirebaseFirestore

class CreateThreadViewModel: ObservableObject {
    func uploadThread(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let thread = Thread(ownerUid: uid, caption: caption, timestamp: Timestamp(), likes: 0)
        try await ThreadService.uploadThread(thread)
    }
}
