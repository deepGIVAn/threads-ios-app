//
//  LoginViewModel.swift
//  Threads
//
//  Created by Deepak on 13/07/26.
//
import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""

    @MainActor
    func login() async throws {
        print("DEBUG: Logging in user...")
        
        try await AuthService.shared.login(
            withEmail: email,
            password: password
        )
    }
        
}
