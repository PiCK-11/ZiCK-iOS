import Foundation

// todo use KeyChain

struct AuthStorage {
    
    static let shared = AuthStorage()
    
    private init() {}
    
    func currentToken() -> String? {
        UserDefaults.standard.string(forKey: "accessToken")
    }
    
    func setCurrentToken(to token: String) {
        UserDefaults.standard.set(token, forKey: "accessToken")
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
    }
    
}
