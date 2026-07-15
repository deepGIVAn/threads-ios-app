//
//  ExploreViewModel.swift
//  Threads
//
//  Created by Deepak on 15/07/26.
//

import Foundation
import Combine

class ExploreViewModel: ObservableObject {
    @Published var users: [User] = []
    
    init() {
        Task { try await fetchUsers() }
    }
    
    @MainActor
    private func fetchUsers() async throws {
        self.users = try await UserService.fetchUsers()
    }
}
