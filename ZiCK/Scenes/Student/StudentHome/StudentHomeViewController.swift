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
    
    struct SceneData {
        let attendStatus: Bool
    }
    
    var sceneData: SceneData? {
        didSet {
            guard let sceneData else { return }
            
            statusView.attended = sceneData.attendStatus
        }
    }
    
    // MARK: - UI
    
    private lazy var statusView = StudentStatusView()
    
    private lazy var attendButton  = UIButton(configuration: UIButton.Configuration.primary().with {
        $0.title = "출석 인증하기"
    }, primaryAction: UIAction { [unowned self] _ in
        delegate?.attendTapped(viewController: self)
    })
    
    func configureUI() {
        title = "ZiCK"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        configureSubviews()
    }
    
    func configureSubviews() {
        view.addSubview(statusView)
        
        statusView.centerYToSuperview()
        statusView.heightToSuperview(multiplier: 0.3, usingSafeArea: true)
        statusView.horizontalToSuperview(insets: .horizontal(.horizontalMargin), usingSafeArea: true)
    }

}

