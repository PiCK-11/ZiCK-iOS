import UIKit

extension UIActivityIndicatorView {
    
    static func loader() -> Self {
        Self().then {
            $0.style = .large
            $0.startAnimating()
        }
    }
    
}

