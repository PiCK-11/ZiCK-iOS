struct CurrentUserResponse: Codable {
    
    let username: String
    let studentNumber: Int?
    let applied: Bool?
    let verified: Bool?

}
