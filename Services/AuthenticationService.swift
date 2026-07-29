import Foundation
import Combine

class AuthenticationService: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let dataPersistence = DataPersistence.shared
    
    init() {
        // Check for saved session
        loadUserSession()
    }
    
    func login(email: String, password: String) -> AnyPublisher<User, Error> {
        // Simulate API call
        return Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                if email == "test@example.com" && password == "password" {
                    let user = User(id: "1", email: email, name: "Test User")
                    promise(.success(user))
                } else {
                    promise(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])))
                }
            }
        }
        .handleEvents(receiveOutput: { [weak self] user in
            self?.currentUser = user
            self?.isAuthenticated = true
            self?.saveUserSession(user)
        })
        .eraseToAnyPublisher()
    }
    
    func logout() {
        isAuthenticated = false
        currentUser = nil
        clearUserSession()
    }
    
    private func saveUserSession(_ user: User) {
        // Save user session to secure storage
        UserDefaults.standard.set(user.id, forKey: "user_id")
        UserDefaults.standard.set(user.email, forKey: "user_email")
        UserDefaults.standard.set(user.name, forKey: "user_name")
    }
    
    private func loadUserSession() {
        guard let id = UserDefaults.standard.string(forKey: "user_id"),
              let email = UserDefaults.standard.string(forKey: "user_email"),
              let name = UserDefaults.standard.string(forKey: "user_name") else {
            return
        }
        
        currentUser = User(id: id, email: email, name: name)
        isAuthenticated = true
    }
    
    private func clearUserSession() {
        UserDefaults.standard.removeObject(forKey: "user_id")
        UserDefaults.standard.removeObject(forKey: "user_email")
        UserDefaults.standard.removeObject(forKey: "user_name")
    }
}

struct User: Codable {
    let id: String
    let email: String
    let name: String
}
