class RootCoordinator: Coordinator {
    
    func start() {
        showChildCoordinator()
    }
    
    private func showChildCoordinator() {
        if authenticated() {
            let authenticatedCoordinator = AuthenticatedCoordinator()
            authenticatedCoordinator.delegate = self
            authenticatedCoordinator.start()
        } else {
            let unAuthenticatedCoordinator = UnAuthenticatedCoordinator()
            unAuthenticatedCoordinator.delegate = self
            unAuthenticatedCoordinator.start()
        }
    }
    
    private func authenticated() -> Bool {
        return true
    }

}

extension RootCoordinator: UnAuthenticatedCoordinatorDelegate {
    
    func finishedAuthentication(coordinator: UnAuthenticatedCoordinator) {
        showChildCoordinator()
    }
    
}

extension RootCoordinator: AuthenticatedCoordinatorDelegate {
    
    func finishedLogOut(coordinator: AuthenticatedCoordinator) {
        showChildCoordinator()
    }
    
}
