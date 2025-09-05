import UIKit

extension UITextField {
    
    static func form() -> UITextField {
        UITextField().then {
            $0.backgroundColor = .secondarySystemBackground
            $0.borderStyle = .roundedRect
        }
    }
    
}

extension UITextField {
    
    var nonEmptyText: String? {
        guard let text else { return nil }
        return text.isEmpty ? nil : text
    }
    
}
