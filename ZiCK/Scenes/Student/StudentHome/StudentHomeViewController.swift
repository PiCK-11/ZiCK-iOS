import UIKit
import Then
import TinyConstraints

protocol StudentHomeViewControllerDelegate {
    
    func attendTapped(viewController: StudentHomeViewController)

}

class StudentHomeViewController: UIViewController {
    
    var delegate: StudentHomeViewControllerDelegate?
    
    init(delegate: StudentHomeViewControllerDelegate? = nil) {
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
    
    private lazy var dateLabel = UILabel().then {
        $0.text = DateFormatter.formatAsHome(from: Date())
    }
    
    private lazy var attendStatusLabel = UILabel().then {
        $0.text = "출석 인증을 하지 않았습니다"
    }
    
    private lazy var attendButton = {
        var configuration = UIButton.Configuration.primary()
        configuration.title = "출석 인증하기"
        return UIButton(configuration: configuration)
    }()
    
    private lazy var stackView = UIStackView(
        arrangedSubviews: [dateLabel, attendStatusLabel, attendButton]
    ).then {
        $0.axis = .vertical
        $0.spacing = 16
    }

    func configureUI() {
        view.backgroundColor = .systemBackground
        configureSubviews()
    }
    
    func configureSubviews() {
        view.addSubview(stackView)
        stackView.center(in: view)
    }

}

