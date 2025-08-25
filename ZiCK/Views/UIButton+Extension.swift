import UIKit

extension UIButton.Configuration {
    
    static func primary() -> UIButton.Configuration {
        .filled()
    }
    
    static func secondary() -> UIButton.Configuration {
        .plain()
    }
    
    static func destructive() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .systemRed
        return configuration
    }
    
}
