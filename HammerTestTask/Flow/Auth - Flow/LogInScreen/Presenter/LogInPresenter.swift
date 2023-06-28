import Foundation

protocol LogInViewProtocol: AnyObject {
    
    var correctLogin: Bool { get set }
    var correctPassword: Bool { get set }
    
    func success()
    func error(message: String)
}

protocol LogInPresenterProtocol: AnyObject {
    
    init(view: LogInViewProtocol, router: RouterAuthProtocol, completionAuth: @escaping () -> Void)
    
    func checkValidation(login: String, password: String)
    func userLogIn()
    func userForgotPassword()
    func userWantToSignIn()
}

final class LogInPresenter: LogInPresenterProtocol {
    
    weak var view: LogInViewProtocol?
    var router: RouterAuthProtocol!
    
    var completionAuth: () -> Void
    
    required init(view: LogInViewProtocol, router: RouterAuthProtocol, completionAuth: @escaping () -> Void) {
        self.view = view
        self.router = router
        self.completionAuth = completionAuth
    }
    
    func checkValidation(login: String, password: String) {
        guard login != ""  else {
            view?.correctLogin = false
            view?.error(message: Constant.emptyLogin.localized())
            return
        }
        guard password != "" else {
            view?.correctPassword = false
            view?.error(message: Constant.emptyPassword.localized())
            return
        }
        guard login == "hudihka" else {
            view?.correctLogin = false
            view?.error(message: Constant.incorrectLogin.localized())
            return
        }
        guard password == "123" else {
            view?.correctPassword = false
            view?.error(message: Constant.incorrectPassword.localized())
            return
        }
        view?.success()
    }
    
    func userLogIn() {
        completionAuth()
    }
    
    func userForgotPassword() {
        router.showResetPassword()
    }
    
    func userWantToSignIn() {
        router.showSignIn()
    }
    
}

extension LogInPresenter {
    
    struct Constant {
        
        static let emptyLogin = "logInPresenter.emptyLogin"
        static let emptyPassword = "logInPresenter.emptyPassword"
        static let incorrectLogin = "logInPresenter.incorrectLogin"
        static let incorrectPassword = "logInPresenter.incorrectPassword"
    }
}
