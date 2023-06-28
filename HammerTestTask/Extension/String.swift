import UIKit

extension String {
    
    func localized() -> String {
        NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self)
    }
    
    static func getGenreName(genre: Genre) -> String {
        
        switch genre {
        case .animation:
            return ProjectConstant.Genre.adventure.localized()
        case .adventure:
            return ProjectConstant.Genre.animation.localized()
        case .drama:
            return ProjectConstant.Genre.drama.localized()
        case .all:
            return ProjectConstant.Genre.all.localized()
        }
    }
    
    private func appPredicateOnRegex(regex: String) -> Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
        return isValidateOtherString
    }
    
    func validateEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return appPredicateOnRegex(regex: regex)
    }
    
    func validateLogin() -> Bool {
        let regex = "^[A-Za-z0-9]{3,30}$"
        return appPredicateOnRegex(regex: regex)
    }
    
    func validateName() -> Bool {
        let regex = "^[A-Za-z]{3,30}$"
        return appPredicateOnRegex(regex: regex)
    }
    
    func validatePassword() -> Bool {
        let regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,30}$"
        return appPredicateOnRegex(regex: regex)
    }
}
