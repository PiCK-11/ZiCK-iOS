import UIKit

protocol CafeteriaHomeViewControllerDelegate {
    
    func scanTapped(viewController: CafeteriaHomeViewController)
    func exportToExcelTapped(viewController: CafeteriaHomeViewController)
    
}

class CafeteriaHomeViewController: UIViewController, HasStrongDelegate {
    
    var delegate: CafeteriaHomeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cafeteria Home"
    }

}

