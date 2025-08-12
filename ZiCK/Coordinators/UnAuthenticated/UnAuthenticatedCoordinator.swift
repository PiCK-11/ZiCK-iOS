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
    
    func login(viewController: LoginViewController) async -> LoginResult {
        do {
            try await AuthUseCase.shared.login()
        } catch {
        }
        return LoginResult()
    }
    
}

extension UnAuthenticatedCoordinator: RegisterViewControllerDelegate {
    
    func switchToLoginTapped(viewController: RegisterViewController) {
        navigator.replace(with: LoginViewController(delegate: self))
    }
    
    func register(viewController: RegisterViewController) async -> RegisterResult {
        do {
            try await AuthUseCase.shared.register()
        } catch {
            return RegisterResult()
        }
        return RegisterResult()
    }
    
}
