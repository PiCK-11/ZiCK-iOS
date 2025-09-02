struct UserUseCase {
    
    static let shared = UserUseCase()
    
    private init() {}
    
    func currentUser() async throws(UseCaseError) -> User {
        guard let token = AuthStorage.shared.currentToken() else {
            throw UseCaseError.invalidAuthentication
        }
        do {
            let response = try await APICaller.shared.currentUser(accessToken: token)
            let role: UserRole = response.studentNumber != nil ? .student : .cafeteria
            return User(id: "0", username: response.username, role: role) // todo: id
        } catch {
            throw UseCaseError(from: error)
        }
    }
    
    func currentStudentDetails() async throws(UseCaseError) -> StudentDetails {
        guard let token = AuthStorage.shared.currentToken() else {
            throw UseCaseError.invalidAuthentication
        }
        do {
            let response = try await APICaller.shared.currentUser(accessToken: token)
            guard let studentNumber = response.studentNumber else {
                throw UseCaseError.invalidAuthorization
            }
            return StudentDetails(
                studentNumber: response.studentNumber!,
                applied: response.applied!,
                attended: response.verified!
            )
        } catch let error as UseCaseError {
            throw error
        } catch {
            throw UseCaseError(from: error as! APIError)
        }
    }
    
}

