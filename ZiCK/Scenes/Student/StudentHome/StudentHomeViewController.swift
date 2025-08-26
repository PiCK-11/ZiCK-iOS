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
            
            attendStatusLabel.text = sceneData.attendStatus
                ? "출석 인증을 완료했습니다"
                : "출석 인증을 하지 않았습니다"
        }
    }
    
    // MARK: -UI
    
    private lazy var dateLabel = UILabel().then {
        $0.text = DateFormatter.formatAsHome(from: Date())
    }
    
    private lazy var attendStatusLabel = UILabel().then { _ in
    }
    
    private lazy var attendButton = {
        var configuration = UIButton.Configuration.primary()
        configuration.title = "출석 인증하기"
        return UIButton(configuration: configuration, primaryAction: UIAction { [unowned self] _ in
            delegate?.attendTapped(viewController: self)
        })
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

