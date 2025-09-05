import UIKit

class StudentStatusView: UIView {
    
    struct AttendStatusImage {
        static let attended = UIImage(systemName: "checkmark.circle.fill")
        static let unattended = UIImage(systemName: "ellipsis.circle.fill")
    }
    
    var attended = false {
        didSet {
            let accentColor: UIColor
            if attended {
                attendStatusImageView.image = AttendStatusImage.attended
                attendStatusLabel.text = "출석 인증을 완료했습니다"
                accentColor = .systemGreen
            } else {
                attendStatusImageView.image = AttendStatusImage.unattended
                attendStatusLabel.text = "출석 인증을 하지 않았습니다"
                accentColor = .systemGray
            }
            backgroundColor = accentColor.withAlphaComponent(0.1)
            layer.borderColor = accentColor.cgColor
            attendStatusImageView.tintColor = accentColor
        }
    }
    
    var refreshTappedHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - UI
    
    private lazy var dateLabel = UILabel().then {
        $0.text = DateFormatter.formatAsHome(from: Date())
        $0.font = .preferredFont(forTextStyle: .title2)
    }
    
    private lazy var attendStatusLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .headline)
    }
    
    private lazy var attendStatusImageView = UIImageView()
    
    private lazy var attendStackView = UIStackView(arrangedSubviews: [attendStatusImageView, attendStatusLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 16
    }
    
    private lazy var refreshButton = UIButton(configuration: .filled().with {
        $0.image = UIImage(systemName: "arrow.clockwise")
        $0.baseBackgroundColor = .systemBackground
        $0.baseForegroundColor = .accent
    }, primaryAction: UIAction { [unowned self] _ in
        refreshTappedHandler?()
    })
    
    func configureUI() {
        let inset: CGFloat = 16
        layer.cornerRadius = 16
        layer.borderWidth = 1
        backgroundColor = .accent.withProminence(.quaternary)
        
        addSubviews(dateLabel, refreshButton, attendStackView)
        
        dateLabel.leadingToSuperview(offset: inset)
        dateLabel.centerY(to: refreshButton)
        
        refreshButton.trailingToSuperview(offset: inset)
        refreshButton.topToSuperview(offset: inset)
        
        attendStatusImageView.width(40)
        attendStatusImageView.heightToWidth(of: attendStatusImageView)
        
        attendStackView.center(in: self)
    }
    
}

