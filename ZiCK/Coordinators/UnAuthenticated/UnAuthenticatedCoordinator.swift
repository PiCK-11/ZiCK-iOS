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
            delegate?.finishedAuthentication(coordinator: self)
        } catch {
            return switch error {
            case .invalidValues:
                LoginResult(errorMessage: "아이디 또는 비밀번호가 올바르지 않습니다")
            default:
                LoginResult(errorMessage: "서버 오류가 발생했습니다")
            }
        }
        return LoginResult(errorMessage: nil)
    }
    
}

extension UnAuthenticatedCoordinator: RegisterViewControllerDelegate {
    
    func switchToLoginTapped(viewController: RegisterViewController) {
        navigator.replace(with: LoginViewController(delegate: self))
    }
    
    func register(viewController: RegisterViewController, username: String, password: String, name: String, studentNumber: Int) async -> RegisterResult {
        do {
            try await AuthUseCase.shared.register(username: username, password: password, name: name, studentNumber: studentNumber)
            delegate?.finishedAuthentication(coordinator: self)
        } catch {
            return switch error {
            case .invalidValues(let reason):
                switch reason {
                case .duplicate:
                    RegisterResult(errorMessage: "이미 존재하는 사용자입니다")
                case .failedValidation:
                    RegisterResult(errorMessage: "입력 형식이 올바르지 않습니다")
                }
            default:
                RegisterResult(errorMessage: "서버 오류가 발생했습니다")
            }
        }
        return RegisterResult(errorMessage: nil)
    }
    
}
