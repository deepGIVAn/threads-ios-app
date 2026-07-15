//
//  Model.swift
//  Threads
//
//  Created by Deepak on 15/07/26.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Thread: Identifiable, Codable, Hashable {
    @DocumentID var threadId: String?
    let ownerUid: String
    let caption: String
    let timestamp: Timestamp
    var likes: Int

    var id: String {
        return threadId ?? NSUUID().uuidString
    }
    var user: User?
}
