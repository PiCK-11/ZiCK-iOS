import Foundation

extension URLRequest {
    
    mutating func setPostBody(as body: any Encodable) throws {
        setValue("application/json", forHTTPHeaderField: "Content-Type")
        httpMethod = "POST"
        httpBody = try JSONEncoder().encode(body)
    }
    
    mutating func addBearerToken(_ token: String) {
        setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    
}

