import UIKit

struct LoginResult {}

protocol LoginViewControllerDelegate {
    
    func switchToRegisterTapped(viewController: LoginViewController)
    func login(viewController: LoginViewController, username: String, password: String) async -> LoginResult

}

class LoginViewController: UIViewController, HasStrongDelegate {
    
    var delegate: LoginViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
    }

}
