struct AuthUseCase {
    
    static let shared = AuthUseCase()
    
    private init() {}
    
    func login(username: String, password: String) async throws(UseCaseError) {
        do {
            let token = try await APICaller.shared.login(request: LoginRequest(username: username, password: password))
            AuthStorage.shared.setCurrentToken(to: token)
        } catch APIError.badRequest {
            throw UseCaseError.invalidValues
        } catch {
            throw UseCaseError.internalFailure
        }
    }
    
    func register(username: String, password: String) async throws(UseCaseError) {
        do {
            let token = try await APICaller.shared.signUp(request: SignUpRequest(username: username, password: password))
            AuthStorage.shared.setCurrentToken(to: token)
        } catch APIError.badRequest {
            throw UseCaseError.invalidValues
        } catch {
            throw UseCaseError.internalFailure
        }
    }
    
}

