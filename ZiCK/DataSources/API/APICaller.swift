import Foundation

struct APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    func signUp(request: SignUpRequest) async throws(APIError) -> String {
        ""
    }
    
    func login(request: LoginRequest) async throws(APIError) -> String {
        ""
    }
    
    func currentStudent(accessToken: String, request: CurrentStudentRequest) async throws(APIError) -> CurrentStudentResponse {
        CurrentStudentResponse(studentNumber: 1, username: "", applied: true)
    }
    
    func qrHash(accessToken: String) async throws(APIError) -> QrResponse {
        QrResponse(key: "")
    }
    
    func markAsAttend(accessToken: String, request: MarkAsAttendRequest) async throws(APIError) -> MarkAsAttendResponse {
        MarkAsAttendResponse(canEnter: true)
    }
    
    func exportAsExcel(accessToken: String) async throws(APIError) -> Data {
        Data()
    }
    
}

