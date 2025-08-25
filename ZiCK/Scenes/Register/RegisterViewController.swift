import UIKit

struct RegisterResult {}

protocol RegisterViewControllerDelegate {
    
    func switchToLoginTapped(viewController: RegisterViewController)
    func register(viewController: RegisterViewController, username: String, password: String) async -> RegisterResult

}

class RegisterViewController: UIViewController {
    
    var delegate: RegisterViewControllerDelegate?
    
    init(delegate: RegisterViewControllerDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
    }

}

