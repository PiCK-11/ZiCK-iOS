import UIKit

protocol AuthenticatedCoordinatorDelegate: AnyObject {
    
    func finishedLogOut(coordinator: AuthenticatedCoordinator)
    
}

@MainActor
class AuthenticatedCoordinator: @preconcurrency Coordinator {
    
    weak var delegate: AuthenticatedCoordinatorDelegate?
    let navigator = NavigationControllerNavigator.shared
    
    func start() {
        navigator.replace(with: LoadingViewController())
        Task {
            let user = try! await UserUseCase.shared.currentUser()
            let coordinator: any Coordinator = switch user.role {
            case .student:
                StudentCoordinator(delegate: self)
            case .cafeteria:
                CafeteriaCoordinator()
            }
            coordinator.start()
        }
    }
    
}

@MainActor
extension AuthenticatedCoordinator: @preconcurrency StudentCoordinatorDelegate {
    
    func loggedOut(coordinator: StudentCoordinator) {
        AuthUseCase.shared.logOut()
        delegate?.finishedLogOut(coordinator: self)
    }
    
}
