//
//  FeedViewModel.swift
//  Threads
//
//  Created by Deepak on 16/07/26.
//

import Foundation
import Combine

@MainActor
class FeedViewModel: ObservableObject {
    @Published var threads : [Thread] = []
    
    init() {
        Task {
            try await fetchThreads()
        }
    }
    
    func fetchThreads() async throws {
        self.threads = try await ThreadService.fetchThreads()
        try await fetchUserDataForThreads()
    }
    
    private func fetchUserDataForThreads() async throws {
        for i in 0 ..< self.threads.count {
            let thread = self.threads[i]
            let ownerUid = thread.ownerUid
            let threadUser = try await UserService.fetchUser(withUid: ownerUid)
            self.threads[i].user = threadUser
        }
    }
}
