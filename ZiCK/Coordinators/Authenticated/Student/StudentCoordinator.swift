import UIKit

protocol StudentCoordinatorDelegate {
    
    func loggedOut(coordinator: StudentCoordinator)
    
}

class StudentCoordinator: Coordinator {
    
    var delegate: StudentCoordinatorDelegate?
    
    init(delegate: StudentCoordinatorDelegate? = nil) {
        self.delegate = delegate
    }
    
    private let navigator = NavigationControllerNavigator.shared
   
    func start() {
        navigator.replace(with: StudentHomeViewController(delegate: self))
    }
    
}

extension StudentCoordinator: StudentHomeViewControllerDelegate {
    
    func attendTapped(viewController: StudentHomeViewController) {
        navigator.navigate(to: StudentQrViewController(delegate: self))
    }
    
}

extension StudentCoordinator: StudentQrViewControllerDelegate {
    
}

extension StudentCoordinator: StudentAccountViewControllerDelegate {
    
    func logoutTapped(viewController: StudentAccountViewController) {
        delegate?.loggedOut(coordinator: self)
    }
    
}
