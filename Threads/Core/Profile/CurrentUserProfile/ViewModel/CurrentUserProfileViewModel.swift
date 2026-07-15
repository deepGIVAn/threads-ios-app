//
//  CurrentUserProfileViewModel.swift
//  Threads
//
//  Created by Deepak on 15/07/26.
//

import Foundation
import Combine

class CurrentUserProfileViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    @Published var currentUser: User?
    
    init(currentUser: User? = nil) {
        self.currentUser = currentUser
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            print("DEBUG: User in view model from combine is \(String(describing: user))")
        }
        .store(in: &cancellables)
    }
}
