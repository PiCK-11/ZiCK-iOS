import UIKit

protocol UnAuthenticatedCoordinatorDelegate: AnyObject {
    
    func finishedAuthentication(coordinator: UnAuthenticatedCoordinator)
    
}

class UnAuthenticatedCoordinator: Coordinator {
    
    weak var delegate: UnAuthenticatedCoordinatorDelegate?
    
    let navigator = NavigationControllerNavigator.shared
    
    func start() {
        navigator.replace(with: LoginViewController(delegate: self))
    }
    
}

extension UnAuthenticatedCoordinator: LoginViewControllerDelegate {
    
    func switchToRegisterTapped(viewController: LoginViewController) {
        navigator.replace(with: RegisterViewController(delegate: self))
    }
    
    func login(viewController: LoginViewController, username: String, password: String) async -> LoginResult {
        do {
            try await AuthUseCase.shared.login(username: username, password: password)
        } catch {
            return LoginResult()
        }
        return LoginResult()
    }
    
}

extension UnAuthenticatedCoordinator: RegisterViewControllerDelegate {
    
    func switchToLoginTapped(viewController: RegisterViewController) {
        navigator.replace(with: LoginViewController(delegate: self))
    }
    
    func register(viewController: RegisterViewController, username: String, password: String) async -> RegisterResult {
        do {
            try await AuthUseCase.shared.register(username: username, password: password)
        } catch {
            return RegisterResult()
        }
        return RegisterResult()
    }
    
}
