struct AuthUseCase {
    
    static let shared = AuthUseCase()
    
    private init() {}
    
    func login(username: String, password: String) async throws(UseCaseError) {
        do {
            let data = try await APICaller.shared.login(request: LoginRequest(loginId: username, password: password))
            AuthStorage.shared.setCurrentToken(to: data.accessToken)
        } catch {
            throw UseCaseError(from: error)
        }
    }
    
    func register(username: String, password: String, name: String, studentNumber: Int) async throws(UseCaseError) {
        do {
            let data = try await APICaller.shared.signUp(
                request: SignUpRequest(
                    loginId: username,
                    userName: name,
                    password: password,
                    studentNumber: studentNumber,
                    role: "STUDENT"
                )
            )
            AuthStorage.shared.setCurrentToken(to: data.accessToken)
        } catch {
            throw UseCaseError(from: error)
        }
    }
    
    func logOut() {
        AuthStorage.shared.clear()
    }
    
}

