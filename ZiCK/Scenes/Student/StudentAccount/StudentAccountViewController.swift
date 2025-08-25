import UIKit

protocol StudentAccountViewControllerDelegate {
    
    func logoutTapped(viewController: StudentAccountViewController)

}

class StudentAccountViewController: UIViewController {

    var delegate: StudentAccountViewControllerDelegate?
    
    init(delegate: StudentAccountViewControllerDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Student Account"
    }

}

