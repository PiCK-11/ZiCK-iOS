import Foundation

struct AttendanceUseCase {
    
    static let shared = AttendanceUseCase()
    
    private init() {}
    
    func hash() async throws(UseCaseError) -> String {
        guard let token = AuthStorage.shared.currentToken() else {
            throw UseCaseError.invalidAuthentication
        }
        do {
            let response = try await APICaller.shared.qrHash(accessToken: token)
            return response.key
        } catch {
            throw UseCaseError(from: error)
        }
    }
    
    func markAsAttend(with hash: String) async throws(UseCaseError) {
        guard let token = AuthStorage.shared.currentToken() else {
            throw UseCaseError.invalidAuthentication
        }
        do {
            let response = try await APICaller.shared.markAsAttend(
                accessToken: token,
                request: MarkAsAttendRequest(key: hash)
            )
        } catch {
            throw UseCaseError(from: error)
        }
    }
    
    func currentEntriesAsExcel() async throws(UseCaseError) -> Data {
        guard let token = AuthStorage.shared.currentToken() else {
            throw UseCaseError.invalidAuthentication
        }
        do {
            return try await APICaller.shared.exportAsExcel(accessToken: token)
        } catch {
            throw UseCaseError(from: error)
        }
    }
    
}

