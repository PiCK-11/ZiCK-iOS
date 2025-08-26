import UIKit
import Then
import TinyConstraints

struct LoginResult {}

protocol LoginViewControllerDelegate {
    
    func switchToRegisterTapped(viewController: LoginViewController)
    func login(viewController: LoginViewController, username: String, password: String) async -> LoginResult

}

class LoginViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate?
    
    init(delegate: LoginViewControllerDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func loginTapped() {
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        // todo validation
        // todo loading
        Task {
            await delegate?.login(viewController: self, username: username, password: password)
        }
    }
    
    // MARK: -UI
    
    private lazy var usernameTextField = UITextField().then {
        $0.placeholder = "아이디"
    }
    
    private lazy var passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호"
        $0.isSecureTextEntry = true
    }
    
    private lazy var loginButton = {
        var configuration = UIButton.Configuration.primary()
        configuration.title = "로그인"
        return UIButton(configuration: configuration, primaryAction: UIAction { [unowned self] _ in
            loginTapped()
        })
    }()
    
    private lazy var signUpButton = {
        var configuration = UIButton.Configuration.secondary()
        configuration.title = "회원가입"
        return UIButton(configuration: configuration, primaryAction: UIAction { [unowned self] _ in
            delegate?.switchToRegisterTapped(viewController: self)
        })
    }()
    
    private lazy var textFieldStackView = UIStackView(
        arrangedSubviews: [usernameTextField, passwordTextField]
    ).then {
        $0.axis = .vertical
        $0.spacing = 16
    }
    
    private lazy var buttonsStackView = UIStackView(
        arrangedSubviews: [loginButton, signUpButton]
    ).then {
        $0.axis = .vertical
        $0.spacing = 16
    }
    
    private lazy var controlsStackView = UIStackView(
        arrangedSubviews: [textFieldStackView, buttonsStackView]
    ).then {
        $0.axis = .vertical
        $0.spacing = 24
    }

    func configureUI() {
        title = "로그인"
        view.backgroundColor = .systemBackground
        
        configureSubviews()
    }
    
    func configureSubviews() {
        view.addSubview(controlsStackView)
        controlsStackView.center(in: view)
    }

}
