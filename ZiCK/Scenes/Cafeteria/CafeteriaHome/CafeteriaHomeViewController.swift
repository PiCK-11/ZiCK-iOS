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
    
    private let date = Date()
    
    enum MealType: String {
        case breakfast = "조식"
        case lunch = "중식"
        case dinner = "석식"
    }
    
    private var mealType: MealType {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        return if hour < 12 {
            .breakfast
        } else if hour < 17 {
            .lunch
        } else {
            .dinner
        }
    }
    
    // MARK: - UI
    
    private lazy var logoImageView = UIImageView().then {
        $0.image = UIImage(named: "Logo")
    }
    
    private lazy var dateLabel = UILabel().then {
        $0.text = DateFormatter.formatAsHome(from: date)
        $0.font = .preferredFont(forTextStyle: .title2)
    }
    
    private lazy var mealTypeLabel = UILabel().then {
        $0.text = mealType.rawValue
        $0.font = .preferredFont(forTextStyle: .title2)
    }
    
    private lazy var qrButton = UIButton(configuration: UIButton.Configuration.primary().with {
        $0.title = "QR 받기"
    }, primaryAction: UIAction { [unowned self] _ in
        delegate?.scanTapped(viewController: self)
    })
    
    private lazy var downloadAsExcelButton = UIButton(configuration: UIButton.Configuration.secondary().with {
        $0.title = "Excel 파일로 다운로드"
    }, primaryAction: UIAction { [unowned self] _ in
        delegate?.exportToExcelTapped(viewController: self)
    })
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        configureSubviews()
    }
    
    func configureSubviews() {
        view.addSubviews(logoImageView, dateLabel, mealTypeLabel, qrButton, downloadAsExcelButton)
        
        logoImageView.widthToSuperview(multiplier: 0.4)
        logoImageView.heightToWidth(of: logoImageView)
        logoImageView.centerXToSuperview()
        logoImageView.topToSuperview(offset: 32, usingSafeArea: true)
        
        dateLabel.center(in: view)
        mealTypeLabel.topToBottom(of: dateLabel, offset: 32)
        mealTypeLabel.centerXToSuperview()
        
        qrButton.horizontalToSuperview(insets: .horizontal(.horizontalMargin))
        qrButton.bottomToTop(of: downloadAsExcelButton, offset: -16)
        
        downloadAsExcelButton.horizontalToSuperview(insets: .horizontal(.horizontalMargin))
        downloadAsExcelButton.bottomToSuperview(offset: -.verticalMargin)
    }

}

