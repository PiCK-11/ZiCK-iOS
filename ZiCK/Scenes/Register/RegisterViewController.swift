import UIKit

struct RegisterResult {}

protocol RegisterViewControllerDelegate {
    
    func switchToLoginTapped(viewController: RegisterViewController)
    func register(viewController: RegisterViewController, username: String, password: String, studentNumber: Int) async -> RegisterResult

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
        
        configureUI()
    }
    
    func registerTapped() {
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let studentNumberString = studentNumberTextField.text else { return }
        // todo validation
        guard let studentNumber = Int(studentNumberString) else { return }
        // todo loading
        Task {
            await delegate?.register(viewController: self, username: username, password: password, studentNumber: studentNumber)
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
    
    private lazy var studentNumberTextField = UITextField().then {
        $0.placeholder = "학번"
    }
    
    private lazy var signUpButton = {
        var configuration = UIButton.Configuration.primary()
        configuration.title = "회원가입"
        return UIButton(configuration: configuration, primaryAction: UIAction { [unowned self] _ in
            registerTapped()
        })
    }()
    
    private lazy var loginButton = {
        var configuration = UIButton.Configuration.secondary()
        configuration.title = "로그인"
        return UIButton(configuration: configuration, primaryAction: UIAction { [unowned self] _ in
            delegate?.switchToLoginTapped(viewController: self)
        })
    }()
    
    private lazy var textFieldStackView = UIStackView(
        arrangedSubviews: [usernameTextField, passwordTextField, studentNumberTextField]
    ).then {
        $0.axis = .vertical
        $0.spacing = 16
    }
    
    private lazy var buttonsStackView = UIStackView(
        arrangedSubviews: [signUpButton, loginButton]
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
        title = "회원가입"
        view.backgroundColor = .systemBackground
        
        configureSubviews()
    }
    
    func configureSubviews() {
        view.addSubview(controlsStackView)
        controlsStackView.center(in: view)
    }

}

