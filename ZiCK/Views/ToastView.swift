import UIKit

class ToastView: UIView {
    
    var clearTextTask: Task<Void, Error>?
    
    var text: String? {
        didSet {
            UIView.animate(withDuration: 0.2, animations: { [unowned self] in
                alpha = text == nil ? 0 : 1
            }) { [unowned self] _ in
                textLabel.text = text
            }
            
            if text != nil {
                clearTextTask?.cancel()
                clearTextTask = Task {
                    do {
                        try await Task.sleep(for: .seconds(2))
                        try Task.checkCancellation()
                        text = nil
                    }
                }
            }
        }
    }
    
    var accent: UIColor = .systemGreen {
        didSet {
             configureBackground()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureUI()
        alpha = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - UI
    
    private lazy var textLabel = UILabel().then {
        $0.textAlignment = .center
    }
    
    func configureUI() {
        configureBackground()
        layer.borderWidth = 1
        layer.cornerRadius = 8
        
        let inset: CGFloat = 16
        
        addSubview(textLabel)
        textLabel.center(in: self)
        textLabel.edgesToSuperview(insets: .uniform(inset))
    }
    
    func configureBackground() {
        backgroundColor = accent.withProminence(.secondary)
        layer.borderColor = accent.cgColor
    }
    
}

