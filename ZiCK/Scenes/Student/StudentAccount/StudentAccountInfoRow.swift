import UIKit

class StudentAccountInfoRow: UIView {
    
    private lazy var headLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .headline)
    }
    
    private lazy var bodyLabel = UILabel()
    
    var head: String = "" {
        didSet {
            headLabel.text = head
        }
    }
    
    var body: String = "" {
        didSet {
            bodyLabel.text = body
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    convenience init(head: String) {
        self.init()
        headLabel.text = head
    }
    
    func configureUI() {
        let inset: CGFloat = 16
        
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 8
        
        addSubviews(headLabel, bodyLabel)
        
        headLabel.verticalToSuperview(insets: .vertical(inset))
        headLabel.leading(to: self, offset: inset)
        
        bodyLabel.verticalToSuperview(insets: .vertical(inset))
        bodyLabel.trailing(to: self, offset: -inset)
    }
    
}
