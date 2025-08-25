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
    
    func exportToExcelTapped(viewController: CafeteriaHomeViewController) {
    }
    
}

extension CafeteriaCoordinator: CafeteriaScanViewControllerDelegate {
    
    func qrReceived(viewController: CafeteriaScanViewController) {
    }
    
}
