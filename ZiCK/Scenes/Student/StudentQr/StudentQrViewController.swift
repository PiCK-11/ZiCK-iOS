import UIKit
import CoreImage.CIFilterBuiltins
import TinyConstraints

protocol StudentQrViewControllerDelegate {
    

}

class StudentQrViewController: UIViewController {
    
    var delegate: StudentQrViewControllerDelegate?
    
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
    
    func qrCode(inputMessage: String) -> UIImage {
        let qrCodeGenerator = CIFilter.qrCodeGenerator()
        qrCodeGenerator.message = inputMessage.data(using: .ascii)!
        qrCodeGenerator.correctionLevel = "H"
        return UIImage(ciImage: qrCodeGenerator.outputImage!)
    }
    
    // MARK: -UI
    
    private lazy var qrImageView = UIImageView(image: qrCode(inputMessage: "test")).then {
        $0.layer.magnificationFilter = .nearest
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        configureSubviews()
    }
    
    func configureSubviews() {
        view.addSubview(qrImageView)
        qrImageView.center(in: view)
        qrImageView.width(300)
        qrImageView.heightToWidth(of: qrImageView)
    }

}

