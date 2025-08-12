struct UserUseCase {
    
    static let shared = UserUseCase()
    
    private init() {}
    
    func currentUser() async throws(UseCaseError) -> User {
        User(id: "0", username: "a", role: .student)
    }
    
    func currentStudentDetails() async throws(UseCaseError) -> StudentDetails {
        StudentDetails(studentNumber: 3, applied: true)
    }
    
}

