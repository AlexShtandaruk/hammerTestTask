import Foundation

enum FontType {
    
    case morserattRegular
    case monserattBold
    
    var value: String {
        switch self {
        case .morserattRegular:
            return "Montserrat-Regular"
        case .monserattBold:
            return "Montserrat-Bold"
        }
    }
}
