import UIKit

protocol Navigator {
    
    func navigate(to viewController: UIViewController)
    func replace(with viewController: UIViewController)
    
}

