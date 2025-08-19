import Foundation

struct AttendanceUseCase {
    
    static let shared = AttendanceUseCase()
    
    private init() {}
    
    func hash() async throws(UseCaseError) -> String {
        do {
            let response = try await APICaller.shared.qrHash(accessToken: AuthStorage.shared.currentToken())
            return response.key
        } catch {
            throw UseCaseError(from: error)
        }
    }
    
    func markAsAttend(with hash: String) async throws(UseCaseError) {
        do {
            let response = try await APICaller.shared.markAsAttend(
                accessToken: AuthStorage.shared.currentToken(),
                request: MarkAsAttendRequest(key: hash)
            )
        } catch {
            throw UseCaseError(from: error)
        }
    }
    
    func currentEntriesAsExcel() async throws(UseCaseError) -> Data {
        do {
            return try await APICaller.shared.exportAsExcel(accessToken: AuthStorage.shared.currentToken())
        } catch {
            throw UseCaseError(from: error)
        }
    }
    
}

