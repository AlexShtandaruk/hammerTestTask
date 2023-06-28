import UIKit

protocol RouterAuthProtocol: RouterProtocol {
    
    func initialView()
    func popToRoot()
    func showSignIn()
    func showPrivicy()
    func showUserAgreement()
    func showResetPassword()
}

final class RouterAuth: RouterAuthProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    var completionAuth: () -> Void
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol?, completionAuth: @escaping () -> Void) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
        self.completionAuth = completionAuth
    }
    
    func initialView() {
        if let navigationController = navigationController {
            guard let logInViewController = assemblyBuilder?.createLogInModule(router: self, completionAuth: completionAuth) else { return }
            navigationController.viewControllers = [logInViewController]
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    func showSignIn() {}
    
    func showResetPassword() {}
    
    func showPrivicy() {}
    
    func showUserAgreement() {}
    
}
