import UIKit

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
        title = "Student Qr"
    }

}

