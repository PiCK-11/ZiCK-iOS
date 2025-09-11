struct CurrentUserResponse: Codable {
    
    let loginId: String
    let userName: String
    let studentNumber: Int?
    let applied: Bool?
    let verified: Bool?

}
