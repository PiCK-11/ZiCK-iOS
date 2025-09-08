import UIKit

struct ExcelExportResult {
    
    let success: Bool
    
}

protocol CafeteriaHomeViewControllerDelegate {
    
    func scanTapped(viewController: CafeteriaHomeViewController)
    func exportToExcelTapped(viewController: CafeteriaHomeViewController) async -> ExcelExportResult

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
    
    func downloadTapped() {
        Task {
            downloadAsExcelButton.startLoading()
            let result = await delegate?.exportToExcelTapped(viewController: self)
            downloadAsExcelButton.stopLoading()
            
            guard let result else { return }
            
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            
            if result.success {
                alertController.title = "엑셀 내보내기 성공"
                alertController.message = "출석 데이터를 .xlsx 파일로 내보냈습니다"
            } else {
                alertController.title = "액셀 내보내기 실패"
                alertController.message = "출석 데이터를 내보내는 데 실패했습니다"
            }
            alertController.addAction(UIAlertAction(title: "확인", style: .default) { _ in
                alertController.dismiss(animated: true)
            })
            
            present(alertController, animated: true)
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
        downloadTapped()
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
