import UIKit

protocol AuthenticatedCoordinatorDelegate: AnyObject {
    
    func finishedLogOut(coordinator: AuthenticatedCoordinator)
    
}

class AuthenticatedCoordinator: Coordinator {
    
    weak var delegate: AuthenticatedCoordinatorDelegate?
    let navigator = NavigationControllerNavigator.shared
    
    func start() {
        let coordinator: any Coordinator = switch currentUserRole() {
        case .student:
            StudentCoordinator(delegate: self)
        case .cafeteria:
            CafeteriaCoordinator()
        }
        coordinator.start()
    }
    
    private func currentUserRole() -> UserRole {
        .cafeteria
    }
    
}

extension AuthenticatedCoordinator: StudentCoordinatorDelegate {
    
    func loggedOut(coordinator: StudentCoordinator) {
        AuthUseCase.shared.logOut()
        delegate?.finishedLogOut(coordinator: self)
    }
    
}
