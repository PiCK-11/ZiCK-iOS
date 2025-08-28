import Foundation

struct APICaller {
    
    static let shared = APICaller()
    
    static let baseURL = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as! String
    
    private func baseRequest(path: String) -> URLRequest {
        var urlComponents = URLComponents(string: APICaller.baseURL)!
        urlComponents.path = path
        return URLRequest(url: urlComponents.url!)
    }
    
    private func apiErrorIfOne(from response: HTTPURLResponse) -> APIError? {
        if (response.statusCode < 400) {
            return nil
        }
        
        return switch response.statusCode {
        case 400:
            .badRequest
        case 401:
            .unAuthorized
        case 403:
            .forbidden
        case 404:
            .notFound
        default:
            .internalServerError
        }
    }
    
    private func callAPI(with urlRequest: URLRequest) async throws(APIError) -> Data {
        guard let (data, response) = try? await URLSession.shared.data(for: urlRequest) else {
            throw APIError.internalServerError
        }
        if let apiError = apiErrorIfOne(from: response as! HTTPURLResponse) {
            throw apiError
        }
        return data
    }
    
    private func decodeOrThrow<T: Decodable>(_ type: T.Type, from data: Data) throws(APIError) -> T {
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw APIError.internalServerError
        }
    }
    
    func signUp(request: SignUpRequest) async throws(APIError) -> SignUpResponse {
        var urlRequest = baseRequest(path: "/auth/signup")
        try? urlRequest.setPostBody(as: request)
        
        let data = try await callAPI(with: urlRequest)
        return try decodeOrThrow(SignUpResponse.self, from: data)
    }
    
    func login(request: LoginRequest) async throws(APIError) -> LoginResponse {
        var urlRequest = baseRequest(path: "/auth/login")
        try? urlRequest.setPostBody(as: request)
        
        let data = try await callAPI(with: urlRequest)
        return try decodeOrThrow(LoginResponse.self, from: data)
    }
    
    func currentUser(accessToken: String) async throws(APIError) -> CurrentUserResponse {
        var urlRequest = baseRequest(path: "/users/me")
        urlRequest.addBearerToken(accessToken)
        
        let data = try await callAPI(with: urlRequest)
        return try decodeOrThrow(CurrentUserResponse.self, from: data)
    }
    
    func qrHash(accessToken: String) async throws(APIError) -> QrResponse {
        var urlRequest = baseRequest(path: "/qr")
        urlRequest.addBearerToken(accessToken)
        
        let data = try await callAPI(with: urlRequest)
        return try decodeOrThrow(QrResponse.self, from: data)
    }
    
    func markAsAttend(accessToken: String, request: MarkAsAttendRequest) async throws(APIError) -> MarkAsAttendResponse {
        var urlRequest = baseRequest(path: "/attendances")
        urlRequest.addBearerToken(accessToken)
        try? urlRequest.setPostBody(as: request)

        let data = try await callAPI(with: urlRequest)
        return try decodeOrThrow(MarkAsAttendResponse.self, from: data)
    }
    
    func exportAsExcel(accessToken: String) async throws(APIError) -> Data {
        var urlRequest = baseRequest(path: "/attendances/excel")
        urlRequest.addBearerToken(accessToken)
        
        let data = try await callAPI(with: urlRequest)
        return data
    }
    
}

