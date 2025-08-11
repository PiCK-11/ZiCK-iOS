import UIKit

class NavigationControllerNavigator: Navigator {
    
    static let shared = NavigationControllerNavigator()
    
    let navigationController = UINavigationController()
    
    func navigate(to viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func replace(with viewController: UIViewController) {
        navigationController.setViewControllers([viewController], animated: true)
    }
    
}

