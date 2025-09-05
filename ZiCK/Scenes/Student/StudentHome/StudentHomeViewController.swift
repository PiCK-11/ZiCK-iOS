import UIKit
import Then
import TinyConstraints

protocol StudentHomeViewControllerDelegate {
    
    func attendTapped(viewController: StudentHomeViewController)
    func refreshTapped(viewController: StudentHomeViewController)

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
            guard let sceneData else {
                loader.isHidden = false
                statusView.isHidden = true
                return
            }
            
            loader.isHidden = true
            statusView.isHidden = false
            
            statusView.attended = sceneData.attendStatus
            attendButton.isHidden = sceneData.attendStatus
        }
    }
    
    // MARK: - UI
    
    private lazy var loader = UIActivityIndicatorView.loader()
    
    private lazy var logoImageView = UIImageView().then {
        $0.image = UIImage(named: "Logo")
    }
    
    private lazy var statusView = StudentStatusView().then {
        $0.isHidden = true
        $0.refreshTappedHandler = { [unowned self] in
            sceneData = nil
            delegate?.refreshTapped(viewController: self)
        }
    }
    
    private lazy var attendButton  = UIButton(configuration: UIButton.Configuration.primary().with {
        $0.title = "출석 인증하기"
    }, primaryAction: UIAction { [unowned self] _ in
        delegate?.attendTapped(viewController: self)
    }).then {
        $0.isHidden = true
    }
    
    func configureUI() {
        title = "ZiCK"
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .systemBackground
        configureSubviews()
    }
    
    func configureSubviews() {
        view.addSubviews(logoImageView, statusView, loader, attendButton)
        
        logoImageView.centerXToSuperview(usingSafeArea: true)
        logoImageView.topToSuperview(offset: 40, usingSafeArea: true)
        logoImageView.width(120)
        logoImageView.heightToWidth(of: logoImageView)
        
        statusView.centerYToSuperview()
        statusView.heightToSuperview(multiplier: 0.3, usingSafeArea: true)
        statusView.horizontalToSuperview(insets: .horizontal(.horizontalMargin), usingSafeArea: true)
        
        loader.center(in: statusView)
        
        attendButton.horizontalToSuperview(insets: .horizontal(.horizontalMargin), usingSafeArea: true)
        attendButton.bottomToSuperview(offset: -.verticalMargin, usingSafeArea: true)
    }

}

