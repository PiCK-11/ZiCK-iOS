struct CurrentUserResponse: Codable {
    
    let userId: String
    let userName: String
    let studentNumber: Int?
    let applied: Bool?
    let verified: Bool?

}
