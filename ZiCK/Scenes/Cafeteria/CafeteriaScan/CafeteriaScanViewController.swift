import UIKit

protocol CafeteriaScanViewControllerDelegate {
    
    func qrReceived(viewController: CafeteriaScanViewController)
    
}

class CafeteriaScanViewController: UIViewController, HasStrongDelegate {
    
    var delegate: CafeteriaScanViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cafeteria Scan"
    }

}
