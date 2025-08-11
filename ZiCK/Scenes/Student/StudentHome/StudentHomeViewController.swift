import UIKit

protocol StudentHomeViewControllerDelegate {
    
    func attendTapped(viewController: StudentHomeViewController)

}

class StudentHomeViewController: UIViewController, HasStrongDelegate {
    
    var delegate: StudentHomeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Student Home"
    }

}

