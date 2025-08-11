import UIKit

protocol StudentAccountViewControllerDelegate {
    
    func logoutTapped(viewController: StudentAccountViewController)

}

class StudentAccountViewController: UIViewController, HasStrongDelegate {
    
    var delegate: StudentAccountViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Student Account"
    }

}

