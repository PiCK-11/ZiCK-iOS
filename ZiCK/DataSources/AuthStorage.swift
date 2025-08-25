struct AuthStorage {
    
    static let shared = AuthStorage()
    
    private init() {}
    
    func currentToken() -> String? {
        nil
    }
    
    func setCurrentToken(to token: String) {}
    
    func clear() {}
    
}
