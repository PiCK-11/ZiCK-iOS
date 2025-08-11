class RootCoordinator: Coordinator {
    
    func start() {
        showChildCoordinator()
    }
    
    private func showChildCoordinator() {
        if authenticated() {
            AuthenticatedCoordinator().start()
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
