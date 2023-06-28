import UIKit

final class CColor: UIColor {
    
    static let custWhite = CColor(hex: "#FFFFFF")
    static let custBlack = CColor(hex: "#1a1a1a")
    static let custRed = CColor(hex: "#FF3044")
    static let custBlue = CColor(hex: "#2688EB")
    static let custDarkGray = CColor(hex: "#949494")
    static let custLightGray = CColor(hex: "#EFEFEF")
    
    static let background = CColor(hex: "E5E5E5")
    static let mainPink = CColor(hex: "FD3A69")
    static let mainBlack = CColor(hex: "1C222B")
    static let mainWhite = CColor(hex: "FFFFFF")
    static let mainGray = CColor(hex: "AAAAAD")
    
    public convenience init(hex: String) {
        
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        if ((cString.count) == 8) {
            r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            b = CGFloat((rgbValue & 0x0000FF)) / 255.0
            a = CGFloat((rgbValue & 0xFF000000)  >> 24) / 255.0
            
        } else if ((cString.count) == 6) {
            r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            b = CGFloat((rgbValue & 0x0000FF)) / 255.0
            a = CGFloat(1.0)
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
