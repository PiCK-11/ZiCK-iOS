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
    
    private func login() async -> Bool {
        
    }
    
    private func register() async -> Bool {
        
    }
    
}

extension UnAuthenticatedCoordinator: LoginViewControllerDelegate {
    
    func switchToRegisterTapped(viewController: LoginViewController) {
        navigator.replace(with: RegisterViewController(delegate: self))
    }
    
    func login(viewController: LoginViewController) async -> LoginResult {
        if await login() {
            
        }
        return LoginResult()
    }
    
}

extension UnAuthenticatedCoordinator: RegisterViewControllerDelegate {
    
    func switchToLoginTapped(viewController: RegisterViewController) {
        navigator.replace(with: LoginViewController(delegate: self))
    }
    
    func register(viewController: RegisterViewController) async -> RegisterResult {
        if await register() {
            
        }
        return RegisterResult()
    }
    
}
