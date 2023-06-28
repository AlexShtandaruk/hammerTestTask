import UIKit

final class CLabel: UILabel {
    
    func createLabel(
        text: String?,
        fontType: String,
        fontSize: CGFloat,
        textColor: UIColor,
        textAligment: NSTextAlignment
    ) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.textColor = textColor
        self.font = UIFont(name: fontType, size: fontSize)
        self.text = text
        self.textAlignment = textAligment
    }
    
    func getAttributedString(
        arrayText:[String]?,
        arrayColors:[UIColor]?
    ) -> NSMutableAttributedString {
        
        let finalAttributedString = NSMutableAttributedString()
        for i in 0 ..< (arrayText?.count)! {
            let attributes = [
                NSAttributedString.Key.foregroundColor: arrayColors?[i]
            ]
            let attributedStr = (NSAttributedString.init(
                string: arrayText?[i] ?? "",
                attributes: attributes as [NSAttributedString.Key : Any]))
            if i != 0 {
                finalAttributedString.append(NSAttributedString.init(string: " "))
            }
            finalAttributedString.append(attributedStr)
        }
        return finalAttributedString
    }
    
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, attributeString.length))
            self.attributedText = attributeString
        }
    }
}
