import UIKit

final class CButton: UIButton {
    
    func createTextButton(
        title: String,
        fontType: String,
        fontSize: CGFloat,
        backgroundColor: UIColor,
        titleColorNormal: UIColor,
        titleColorHighlighted: UIColor,
        target: Any?,
        action: Selector
    ) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel?.textAlignment = .center
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColorNormal, for: .normal)
        self.setTitleColor(titleColorHighlighted, for: .highlighted)
        self.titleLabel?.font = UIFont(name: fontType, size: fontSize)
        self.addTarget(target, action: action, for: .touchUpInside)
    }
}
