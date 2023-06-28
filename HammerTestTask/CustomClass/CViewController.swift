import UIKit

protocol ViewControllerProtocol {
    
    func setUI()
    func setView(view: UIView, subView: [UIView])
    func setConstraint()
}

extension ViewControllerProtocol {
    func setView(view: UIView, subView: [UIView]) {
        for i in subView { view.addSubview(i) }
    }
}
