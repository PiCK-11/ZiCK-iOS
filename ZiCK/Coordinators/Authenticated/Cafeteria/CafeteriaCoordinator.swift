import UIKit

class CafeteriaCoordinator: Coordinator {
   
    private let navigator = NavigationControllerNavigator.shared
   
    func start() {
        navigator.replace(with: CafeteriaHomeViewController(delegate: self))
    }
    
}

extension CafeteriaCoordinator: CafeteriaHomeViewControllerDelegate {
    
    func scanTapped(viewController: CafeteriaHomeViewController) {
        navigator.navigate(to: CafeteriaScanViewController(delegate: self))
    }
    
    func exportToExcelTapped(viewController: CafeteriaHomeViewController) async -> ExcelExportResult {
        guard let data = try? await AttendanceUseCase.shared.currentEntriesAsExcel() else {
            return ExcelExportResult(success: false)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        let filename = "attendance-\(dateFormatter.string(from: Date())).xlsx"
        let url = URL.documentsDirectory.appending(path: filename)
        
        do {
            try data.write(to: url, options: [.atomic, .completeFileProtection])
            return ExcelExportResult(success: true)
        } catch {
            print(error)
            return ExcelExportResult(success: false)
        }
    }
    
}

extension CafeteriaCoordinator: CafeteriaScanViewControllerDelegate {
    
    func qrReceived(viewController: CafeteriaScanViewController, message: String) async -> QrReceiveResult {
        do {
            try await AttendanceUseCase.shared.markAsAttend(with: message)
            return QrReceiveResult(success: true)
        } catch {
            return QrReceiveResult(success: false)
        }
    }
    
}
