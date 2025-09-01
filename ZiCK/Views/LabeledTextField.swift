import UIKit

class LabeledTextField: UIView {
    
    lazy var label = UILabel()
    lazy var field = UITextField.form()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureUI() {
        addSubview(label)
        label.leading(to: self)
        label.centerY(to: self)
        label.height(to: self)
        
        addSubview(field)
        field.leadingToTrailing(of: label, offset: 16)
        field.trailing(to: self)
        field.centerY(to: self)
    }
    
}

extension LabeledTextField {
    
    static func align(_ labeledTextFields: LabeledTextField...) {
        for labeledTextField in labeledTextFields.dropFirst() {
            labeledTextField.label.width(to: labeledTextFields.first!.label)
        }
    }
    
}
