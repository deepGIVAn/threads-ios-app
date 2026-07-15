import FirebaseAuth
import Combine
import FirebaseFirestore

class AuthService: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?

    static let shared = AuthService()

    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            // Fetch app user profile from Firestore and set it on UserService
            let uid = result.user.uid
            let doc = try await Firestore.firestore().collection("users").document(uid).getDocument()
            if let data = doc.data() {
                do {
                    let appUser = try Firestore.Decoder().decode(User.self, from: data)
                    UserService.shared.currentUser = appUser
                } catch {
                    print("DEBUG: Failed to decode app user: \(error)")
                }
            } else {
                print("DEBUG: No user document found for uid: \(uid)")
            }
            print("DEBUG: Logged in: \(result.user.uid)")
        } catch {
            throw error
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            UserService.shared.currentUser = User(id: result.user.uid, fullname: fullname, email: email, username: username)
            try await uploadUserData(withEmail: email, fullname: fullname, username: username, id: result.user.uid)
            print("DEBUG: User created: \(result.user.uid)")
        } catch {
            print("DEBUG: Error creating user: \(error)")
            throw error
        }
    }
    
    @MainActor
    func signOut() throws {
        try? Auth.auth().signOut()
        self.userSession = nil
        UserService.shared.reset()
    }
    
    @MainActor
    private func uploadUserData(withEmail email: String, fullname: String, username: String, id: String) async throws {
        let user = User(id: id, fullname: fullname, email: email, username: username)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(userData)
    }
}
