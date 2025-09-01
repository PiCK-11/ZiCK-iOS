import UIKit
import Then

extension UIButton.Configuration {
    
    private static let verticalInset: CGFloat = 12
    
    static func primary() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets.top = verticalInset
        configuration.contentInsets.bottom = verticalInset
        return configuration
    }
    
    static func secondary() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets.top = verticalInset
        configuration.contentInsets.bottom = verticalInset
        return configuration
    }
    
    static func destructive() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .systemRed
        configuration.contentInsets.top = verticalInset
        configuration.contentInsets.bottom = verticalInset
        return configuration
    }
    
}


extension UIButton.Configuration: @retroactive Then {}
