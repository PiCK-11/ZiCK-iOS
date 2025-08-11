import UIKit

class AuthenticatedCoordinator: Coordinator {
    
    let navigator = NavigationControllerNavigator.shared
    
    func start() {
        let coordinator: any Coordinator = switch currentUserRole() {
        case .student:
            StudentCoordinator()
        case .cafeteria:
            CafeteriaCoordinator()
        }
        coordinator.start()
    }
    
    private func currentUserRole() -> UserRole {
        .cafeteria
    }
    
}
