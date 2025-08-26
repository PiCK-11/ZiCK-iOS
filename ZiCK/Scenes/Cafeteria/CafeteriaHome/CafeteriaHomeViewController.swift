import UIKit

protocol CafeteriaHomeViewControllerDelegate {
    
    func scanTapped(viewController: CafeteriaHomeViewController)
    func exportToExcelTapped(viewController: CafeteriaHomeViewController)
    
}

class CafeteriaHomeViewController: UIViewController {
    
    var delegate: CafeteriaHomeViewControllerDelegate?
    
    init(delegate: CafeteriaHomeViewControllerDelegate? = nil) {
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
    
    private lazy var mealTypeLabel = UILabel().then {
        $0.text = "조식"
    }
    
    private lazy var qrButton = {
        var configuration = UIButton.Configuration.primary()
        configuration.title = "QR 받기"
        return UIButton(configuration: configuration, primaryAction: UIAction { [unowned self] _ in
            delegate?.scanTapped(viewController: self)
        })
    }()
    
    private lazy var downloadAsExcelButton = {
        var configuration = UIButton.Configuration.primary()
        configuration.title = "Excel 파일로 다운로드"
        return UIButton(configuration: configuration, primaryAction: UIAction { [unowned self] _ in
            delegate?.exportToExcelTapped(viewController: self)
        })
    }()
    
    private lazy var stackView = UIStackView(
        arrangedSubviews: [dateLabel, mealTypeLabel, qrButton, downloadAsExcelButton]
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

