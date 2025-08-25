import UIKit

protocol StudentHomeViewControllerDelegate {
    
    func attendTapped(viewController: StudentHomeViewController)

}

class StudentHomeViewController: UIViewController {
    
    var delegate: StudentHomeViewControllerDelegate?
    
    init(delegate: StudentHomeViewControllerDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Student Home"
    }

}

