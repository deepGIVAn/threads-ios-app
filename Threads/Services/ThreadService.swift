//
//  ThreadService.swift
//  Threads
//
//  Created by Deepak on 15/07/26.
//

import Foundation
import Firebase
import FirebaseFirestore
import Combine

struct ThreadService {
    static func uploadThread(_ thread: Thread) async throws {
        // Use Firestore.Encoder to produce a Firestore-compatible dictionary
        let data = try Firestore.Encoder().encode(thread)
        try await Firestore.firestore()
            .collection("threads")
            .addDocument(data: data)
    }
}
