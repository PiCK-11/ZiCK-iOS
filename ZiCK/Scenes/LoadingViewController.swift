import UIKit

class LoadingViewController: UIViewController {
    
    override func viewDidLoad() {
        configureUI()
    }
    
    // MARK: - UI
    
    lazy var activityIndicator = UIActivityIndicatorView.loader()
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(activityIndicator)
        activityIndicator.center(in: view)
    }
    
}

