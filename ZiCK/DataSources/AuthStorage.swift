struct AuthStorage {
    
    static let shared = AuthStorage()
    
    private init() {}
    
    func currentToken() -> String {}
    
    func setCurrentToken(to token: String) {}
    
}
