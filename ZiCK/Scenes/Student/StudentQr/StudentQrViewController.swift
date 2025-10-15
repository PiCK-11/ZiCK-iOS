import UIKit
import CoreImage.CIFilterBuiltins
import TinyConstraints

protocol StudentQrViewControllerDelegate {
    

}

class StudentQrViewController: UIViewController {
    
    var delegate: StudentQrViewControllerDelegate?
    
    private var originalBrightness: CGFloat = 0
    
    init(delegate: StudentQrViewControllerDelegate? = nil) {
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
        var message: String
    }
    
    var sceneData: SceneData? {
        didSet {
            guard let sceneData else { return }
            qrImageView.image = qrCode(inputMessage: sceneData.message)
        }
    }
    
    func qrCode(inputMessage: String) -> UIImage {
        let qrCodeGenerator = CIFilter.qrCodeGenerator()
        qrCodeGenerator.message = inputMessage.data(using: .ascii)!
        qrCodeGenerator.correctionLevel = "H"
        return UIImage(ciImage: qrCodeGenerator.outputImage!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            originalBrightness = UIScreen.main.brightness
            
            UIScreen.main.brightness = 1.0
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            UIScreen.main.brightness = originalBrightness // 밝기 복원
        }
    
    // MARK: -UI
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "QR코드를 급식실 화면에 보이게 가까이 대주세요"
        $0.textColor = .secondaryLabel
    }
    
    private lazy var qrImageView = UIImageView().then {
        $0.layer.magnificationFilter = .nearest
    }
    
    func configureUI() {
        title = "QR 스캔"
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .systemBackground
        configureSubviews()
    }
    
    func configureSubviews() {
        view.addSubviews(titleLabel, qrImageView)
        
        titleLabel.centerXToSuperview()
        titleLabel.bottomToTop(of: qrImageView, offset: -32)
        
        qrImageView.center(in: view)
        qrImageView.width(300)
        qrImageView.heightToWidth(of: qrImageView)
    }

}

