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
    
    // MARK: -UI
    
    let rows: [(String, String)] = [
        ("학번", "1100"),
        ("이름", "홍길동"),
        ("주말 급식", "신청")
    ]
    
    var headLabels: [UILabel] {
        rows.map { row in
            UILabel().then {
                $0.text = row.0
            }
        }
    }
    
    var valueLabels: [UILabel] {
        rows.map { row in
            UILabel().then {
                $0.text = row.1
            }
        }
    }
    
    let tableSpacing: CGFloat = 6
    let horizontalMargin: CGFloat = 12
    let verticalMargin: CGFloat = 20
    
    private lazy var headStackView = UIStackView(arrangedSubviews: headLabels).then {
        $0.axis = .vertical
        $0.spacing = tableSpacing
    }
    
    private lazy var valueStackView = UIStackView(arrangedSubviews: valueLabels).then {
        $0.axis = .vertical
        $0.alignment = .trailing
        $0.spacing = tableSpacing
    }
    
    private lazy var logOutButton = {
        var configuration = UIButton.Configuration.destructive()
        configuration.title = "로그아웃"
        return UIButton(configuration: configuration)
    }()

    func configureUI() {
        title = "마이페이지"
        view.backgroundColor = .systemBackground
        configureSubviews()
    }
    
    func configureSubviews() {
        view.addSubview(headStackView)
        headStackView.top(to: view.safeAreaLayoutGuide, offset: verticalMargin)
        headStackView.leading(to: view.safeAreaLayoutGuide, offset: horizontalMargin)
        
        view.addSubview(valueStackView)
        valueStackView.leadingToTrailing(of: headStackView, offset: tableSpacing)
        valueStackView.top(to: headStackView)
        valueStackView.trailing(to: view.safeAreaLayoutGuide, offset: -horizontalMargin)

        view.addSubview(logOutButton)
        logOutButton.leading(to: view.safeAreaLayoutGuide, offset: horizontalMargin)
        logOutButton.trailing(to: view.safeAreaLayoutGuide, offset: -horizontalMargin)
        logOutButton.bottom(to: view.safeAreaLayoutGuide, offset: -verticalMargin)
    }

}

