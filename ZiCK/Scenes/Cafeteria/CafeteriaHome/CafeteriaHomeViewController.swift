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
        title = "Cafeteria Home"
    }

}

