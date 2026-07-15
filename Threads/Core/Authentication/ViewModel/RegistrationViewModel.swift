import Foundation
import Combine

class RegistrationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var fullname: String = ""
    @Published var username: String = ""

    enum Keys {
        static let baseURL = "API_BASE_URL"
    }
    
    static let apiBaseURL: String = {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: Keys.baseURL) as? String else {
            fatalError("API_BASE_URL not found in Info.plist")
        }
        return urlString
    }()
    
    @MainActor
    func createUser() async throws {
        print("DEBUG: Creating user...")
        
        print(Self.apiBaseURL)
        
        try await AuthService.shared.createUser(
            withEmail: email,
            password: password,
            fullname: fullname,
            username: username,
        )
    }
 }
