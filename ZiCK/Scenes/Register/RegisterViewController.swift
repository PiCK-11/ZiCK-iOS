import UIKit

struct RegisterResult {}

protocol RegisterViewControllerDelegate {
    
    func switchToLoginTapped(viewController: RegisterViewController)
    func register(viewController: RegisterViewController, username: String, password: String) async -> RegisterResult

}

class RegisterViewController: UIViewController, HasStrongDelegate {
    
    var delegate: RegisterViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
    }

}

