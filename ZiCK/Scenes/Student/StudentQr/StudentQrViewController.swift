import UIKit

protocol StudentQrViewControllerDelegate {
    

}

class StudentQrViewController: UIViewController, HasStrongDelegate {
    
    var delegate: StudentQrViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Student Qr"
    }

}

