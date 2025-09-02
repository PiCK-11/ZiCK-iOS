import UIKit

struct RegisterResult {}

protocol RegisterViewControllerDelegate {
    
    func switchToLoginTapped(viewController: RegisterViewController)
    func register(viewController: RegisterViewController, username: String, password: String, name: String, studentNumber: Int) async -> RegisterResult

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
        guard let username = usernameTextField.field.text else { return }
        guard let password = passwordTextField.field.text else { return }
        guard let name = nameTextField.field.text else { return }
        guard let studentNumberString = studentNumberTextField.field.text else { return }
        // todo validation
        guard let studentNumber = Int(studentNumberString) else { return }
        // todo loading
        Task {
            await delegate?.register(viewController: self, username: username, password: password, name: name, studentNumber: studentNumber)
        }
    }
    
    // MARK: -UI
    
    private lazy var logoImageView = UIImageView().then {
        $0.image = UIImage(named: "Logo")
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font =  .preferredFont(forTextStyle: .extraLargeTitle)
        $0.text = "회원가입"
    }
    
    private lazy var usernameTextField = LabeledTextField().then {
        $0.label.text = "아이디"
    }
    
    private lazy var passwordTextField = LabeledTextField().then {
        $0.label.text = "비밀번호"
        $0.field.isSecureTextEntry = true
    }
    
    private lazy var nameTextField = LabeledTextField().then {
        $0.label.text = "이름"
    }
    
    private lazy var studentNumberTextField = LabeledTextField().then {
        $0.label.text = "학번"
    }
    
    private lazy var signUpButton = UIButton(configuration: UIButton.Configuration.primary().with {
        $0.title = "회원가입"
    }, primaryAction: UIAction { [unowned self] _ in
        registerTapped()
    })
    
    private lazy var loginButton = UIButton(configuration: UIButton.Configuration.secondary().with {
        $0.title = "로그인"
    }, primaryAction: UIAction { [unowned self] _ in
        delegate?.switchToLoginTapped(viewController: self)
    })
    
    private lazy var textFieldStackView = UIStackView(
        arrangedSubviews: [
            usernameTextField,
            passwordTextField,
            nameTextField,
            studentNumberTextField
        ]
    ).then {
        $0.axis = .vertical
        $0.spacing = 32
    }
    
    private lazy var buttonsStackView = UIStackView(
        arrangedSubviews: [signUpButton, loginButton]
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
            buttonsStackView
        )
        
        LabeledTextField.align(
            usernameTextField,
            passwordTextField,
            nameTextField,
            studentNumberTextField
        )

        logoImageView.width(180)
        logoImageView.height(180)
        logoImageView.centerX(to: view)
        logoImageView.top(to: view.safeAreaLayoutGuide, offset: 40)
        
        titleLabel.centerX(to: view)
        titleLabel.topToBottom(of: logoImageView, offset: 24)
        
        textFieldStackView.topToBottom(of: titleLabel, offset: 32)
        textFieldStackView.leading(to: view.safeAreaLayoutGuide, offset: .horizontalMargin)
        textFieldStackView.trailing(to: view.safeAreaLayoutGuide, offset: -.horizontalMargin)
        
        buttonsStackView.leading(to: view.safeAreaLayoutGuide, offset: .horizontalMargin)
        buttonsStackView.trailing(to: view.safeAreaLayoutGuide, offset: -.horizontalMargin)
        buttonsStackView.bottom(to: view.safeAreaLayoutGuide, offset: -.verticalMargin)
    }

}

