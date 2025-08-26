import UIKit

protocol StudentCoordinatorDelegate {
    
    func loggedOut(coordinator: StudentCoordinator)
    
}

@MainActor
class StudentCoordinator: @preconcurrency Coordinator {
    
    var delegate: StudentCoordinatorDelegate?
    
    init(delegate: StudentCoordinatorDelegate? = nil) {
        self.delegate = delegate
    }
    
    private let navigator = NavigationControllerNavigator.shared
   
    func start() {
        let homeViewController = StudentHomeViewController(delegate: self)
        Task {
            do {
                let studentDetails = try await UserUseCase.shared.currentStudentDetails()
                homeViewController.sceneData = StudentHomeViewController.SceneData(attendStatus: studentDetails.attended)
            } catch {
                // todo
            }
        }
        navigator.replace(with: homeViewController)
    }
    
}

@MainActor
extension StudentCoordinator: @preconcurrency StudentHomeViewControllerDelegate {
    
    func attendTapped(viewController: StudentHomeViewController) {
        let qrViewController = StudentQrViewController(delegate: self)
        Task {
            do {
                let hash = try await AttendanceUseCase.shared.hash()
                qrViewController.sceneData = StudentQrViewController.SceneData(message: hash)
            } catch {
                // todo
            }
        }
        navigator.navigate(to: qrViewController)
    }
    
}

extension StudentCoordinator: StudentQrViewControllerDelegate {
    
}

@MainActor
extension StudentCoordinator: @preconcurrency StudentAccountViewControllerDelegate {
    
    func logoutTapped(viewController: StudentAccountViewController) {
        delegate?.loggedOut(coordinator: self)
    }
    
}
