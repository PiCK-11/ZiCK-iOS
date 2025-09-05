protocol RootCoordinatorDelegate: AnyObject {
    
    func finishedInit(coordinator: RootCoordinator)
    
}

@MainActor
class RootCoordinator: @preconcurrency Coordinator {
    
    weak var delegate: RootCoordinatorDelegate?
    
    func start() {
        showChildCoordinator()
    }
    
    private func showChildCoordinator() {
        Task {
            let user = try? await UserUseCase.shared.currentUser()
            if user != nil {
                let authenticatedCoordinator = AuthenticatedCoordinator()
                authenticatedCoordinator.delegate = self
                authenticatedCoordinator.start()
            } else {
                let unAuthenticatedCoordinator = UnAuthenticatedCoordinator()
                unAuthenticatedCoordinator.delegate = self
                unAuthenticatedCoordinator.start()
            }
            delegate?.finishedInit(coordinator: self)
        }
    }

}

@MainActor
extension RootCoordinator: @preconcurrency UnAuthenticatedCoordinatorDelegate {
    
    func finishedAuthentication(coordinator: UnAuthenticatedCoordinator) {
        showChildCoordinator()
    }
    
}

@MainActor
extension RootCoordinator: @preconcurrency AuthenticatedCoordinatorDelegate {
    
    func finishedLogOut(coordinator: AuthenticatedCoordinator) {
        showChildCoordinator()
    }
    
}
