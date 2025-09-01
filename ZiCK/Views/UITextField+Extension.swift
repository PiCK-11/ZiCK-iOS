import UIKit

extension UITextField {
    
    static func form() -> UITextField {
        UITextField().then {
            $0.backgroundColor = .secondarySystemBackground
            $0.borderStyle = .roundedRect
        }
    }
    
}

