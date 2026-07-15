//
//  UserService.swift
//  Threads
//
//  Created by Deepak on 14/07/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

class UserService: ObservableObject {
    @Published var currentUser: User?
    
    init() {
        Task {
            try await fetchCurrentUser()
        }
    }
    
    static let shared = UserService()
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
        
        print("DEBUG: User is \(user)")
    }
    
    func reset() {
        self.currentUser = nil
    }
    
    static func fetchUsers() async throws -> [User] {
        guard let currentUid = Auth.auth().currentUser?.uid else {
            return []
        }
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        let users = snapshot.documents.compactMap({ try? $0.data(as: User.self) })
        return users.filter({ $0.id != currentUid })
    }
    
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        return user
    }
    
    func updateUserProfileImage(withImageUrl imageUrl: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore().collection("users").document(currentUid).updateData(["profileImageUrl": imageUrl])
        self.currentUser?.profileImageUrl = imageUrl
    }
}
