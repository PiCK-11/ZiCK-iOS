import UIKit

protocol StudentAccountViewControllerDelegate {
    
    func logoutTapped(viewController: StudentAccountViewController)

}

class StudentAccountViewController: UIViewController {

    var delegate: StudentAccountViewControllerDelegate?
    
    init(delegate: StudentAccountViewControllerDelegate? = nil) {
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
    
    struct SceneData {
        let studentNumber: Int
        let name: String
        let applied: Bool
    }
    
    var sceneData: SceneData? {
        didSet {
            guard let sceneData else { return }
            studentNumberRow.body = String(sceneData.studentNumber)
            nameRow.body = sceneData.name
            appliedRow.body = sceneData.applied ? "신청" : "미신청"
        }
    }
    
    // MARK: -UI
    
    private lazy var studentNumberRow = StudentAccountInfoRow(head: "학번")
    private lazy var nameRow = StudentAccountInfoRow(head: "이름")
    private lazy var appliedRow = StudentAccountInfoRow(head: "주말 급식")
    
    private lazy var rowsStackView = UIStackView(
        arrangedSubviews: [
            studentNumberRow,
            nameRow,
            appliedRow
        ]
    ).then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.distribution = .fill
    }
    
    private lazy var logOutButton = UIButton(configuration: UIButton.Configuration.destructive().with {
        $0.title = "로그아웃"
    }, primaryAction: UIAction { [unowned self] _ in
        delegate?.logoutTapped(viewController: self)
    })

    func configureUI() {
        title = "마이페이지"
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .systemBackground
        configureSubviews()
    }
    
    func configureSubviews() {
        view.addSubviews(
            rowsStackView,
            logOutButton
        )
        
        rowsStackView.horizontalToSuperview(insets: .horizontal(.horizontalMargin), usingSafeArea: true)
        rowsStackView.topToSuperview(offset: 60, usingSafeArea: true)
        
        logOutButton.horizontalToSuperview(insets: .horizontal(.horizontalMargin), usingSafeArea: true)
        logOutButton.bottomToSuperview(offset: -.verticalMargin, usingSafeArea: true)
    }

}

