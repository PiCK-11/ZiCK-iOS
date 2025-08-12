import Foundation

struct AttendanceUseCase {
    
    static let shared = AttendanceUseCase()
    
    private init() {}
    
    func hash() async throws(UseCaseError) -> String {
        ""
    }
    
    func markAsAttend(with hash: String) async throws(UseCaseError) {
    }
    
    func currentEntriesAsExcel() async -> Data {
        Data()
    }
    
}

