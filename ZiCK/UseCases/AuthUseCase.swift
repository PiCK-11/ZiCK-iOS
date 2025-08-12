struct AuthUseCase {
    
    static let shared = AuthUseCase()
    
    private init() {}
    
    func login() async throws(UseCaseError) {
    }
    
    func register() async throws(UseCaseError) {
    }
    
}

