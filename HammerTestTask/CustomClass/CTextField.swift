import UIKit

final class CTextField: UITextField {
    
    func createTextField(
        fontSize: CGFloat,
        backgroundColor: UIColor,
        cornerRadius: CGFloat,
        borderColor: CGColor,
        borderWidth: CGFloat,
        textColor: UIColor,
        placeholderText: String,
        placeholderColor: UIColor
    ) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont(name: FontType.morserattRegular.value, size: fontSize)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
        self.textAlignment = .center
        self.textColor = textColor
        self.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
    }
}

