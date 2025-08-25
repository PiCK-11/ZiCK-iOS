import UIKit

protocol CafeteriaScanViewControllerDelegate {
    
    func qrReceived(viewController: CafeteriaScanViewController)
    
}

class CafeteriaScanViewController: UIViewController {
    
    var delegate: CafeteriaScanViewControllerDelegate?
    
    init(delegate: CafeteriaScanViewControllerDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cafeteria Scan"
    }

}
