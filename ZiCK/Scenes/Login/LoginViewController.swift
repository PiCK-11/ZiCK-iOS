import UIKit
import Then
import TinyConstraints

struct LoginResult {
    
    let errorMessage: String?
    
}

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
        guard let username = usernameTextField.field.nonEmptyText else {
            showErrorMessage("아이디를 입력해주세요")
            return
        }
        guard let password = passwordTextField.field.nonEmptyText else {
            showErrorMessage("비밀번호를 입력해주세요")
            return
        }
        
        Task {
            loginButton.startLoading()
            let result = await delegate?.login(viewController: self, username: username, password: password)
            loginButton.stopLoading()
            
            if let message = result?.errorMessage {
                showErrorMessage(message)
            }
        }
    }
    
    func showErrorMessage(_ message: String) {
        errorMessageLabel.text = message
    }
    
    // MARK: -UI
    
    private lazy var logoImageView = UIImageView().then {
        $0.image = UIImage(named: "Logo")
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font =  .preferredFont(forTextStyle: .extraLargeTitle)
        $0.text = "로그인"
    }
    
    private lazy var usernameTextField = LabeledTextField().then {
        $0.label.text = "아이디"
    }
    
    private lazy var passwordTextField = LabeledTextField().then {
        $0.label.text = "비밀번호"
        $0.field.isSecureTextEntry = true
    }
    
    private lazy var loginButton = UIButton(configuration: UIButton.Configuration.primary().with {
        $0.title = "로그인"
    }, primaryAction: UIAction { [unowned self] _ in
        loginTapped()
    })
    
    private lazy var registerButton = UIButton(configuration: UIButton.Configuration.secondary().with {
        $0.title = "회원가입"
    }, primaryAction: UIAction { [unowned self] _ in
        delegate?.switchToRegisterTapped(viewController: self)
    })
    
    private lazy var textFieldStackView = UIStackView(
        arrangedSubviews: [usernameTextField, passwordTextField]
    ).then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 32
    }
    
    private lazy var errorMessageLabel = UILabel().then {
        $0.textColor = .systemRed
    }
    
    private lazy var buttonsStackView = UIStackView(
        arrangedSubviews: [loginButton, registerButton]
    ).then {
        $0.axis = .vertical
        $0.spacing = 16
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        configureSubviews()
    }
    
    func configureSubviews() {
        view.addSubviews(
            logoImageView,
            titleLabel,
            textFieldStackView,
            errorMessageLabel,
            buttonsStackView
        )
        
        LabeledTextField.align(usernameTextField, passwordTextField)

        logoImageView.width(180)
        logoImageView.height(180)
        logoImageView.centerX(to: view)
        logoImageView.top(to: view.safeAreaLayoutGuide, offset: 40)
        
        titleLabel.centerX(to: view)
        titleLabel.topToBottom(of: logoImageView, offset: 24)
        
        textFieldStackView.topToBottom(of: titleLabel, offset: 32)
        textFieldStackView.leading(to: view.safeAreaLayoutGuide, offset: .horizontalMargin)
        textFieldStackView.trailing(to: view.safeAreaLayoutGuide, offset: -.horizontalMargin)
        
        errorMessageLabel.topToBottom(of: textFieldStackView, offset: 32)
        errorMessageLabel.centerXToSuperview(usingSafeArea: true)
        
        buttonsStackView.leading(to: view.safeAreaLayoutGuide, offset: .horizontalMargin)
        buttonsStackView.trailing(to: view.safeAreaLayoutGuide, offset: -.horizontalMargin)
        buttonsStackView.bottom(to: view.safeAreaLayoutGuide, offset: -.verticalMargin)
    }

}
