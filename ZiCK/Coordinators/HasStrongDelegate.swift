import UIKit

protocol HasStrongDelegate: AnyObject {
    
    associatedtype Delegate
    
    var delegate: Delegate? { get set }
    
}

extension HasStrongDelegate {
    
    init(delegate: Delegate) {
        self.delegate = delegate
    }
    
}

