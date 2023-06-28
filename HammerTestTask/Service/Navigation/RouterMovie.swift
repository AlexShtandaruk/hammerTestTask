import UIKit

protocol RouterMovieProtocol: RouterProtocol {
    
    func initialView()
    func showObjects(data: Movie?)
    func popToRoot()
}

final class RouterMovie: RouterMovieProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    var completionAuth: () -> Void
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol, completionAuth: @escaping () -> Void) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
        self.completionAuth = completionAuth
    }
    
    func initialView() {
        if let navigationController = navigationController {
            guard let categoryViewController = assemblyBuilder?.createMovieListModule(router: self) else { return }
            navigationController.viewControllers = [TabBarController(viewController: categoryViewController)]
        }
    }
    
    func showObjects(data: Movie?) {
        if let navigationController = navigationController {
            guard let objectViewController = assemblyBuilder?.createObjectModule(data: data, router: self, completionAuth: completionAuth) else { return }
            navigationController.pushViewController(objectViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}


/*
func initialView() {
    if let navigationController = navigationController {
        guard let categoryViewController = assemblyBuilder?.createMovieListModule(router: self) else { return }
        navigationController.viewControllers = [categoryViewController]
    }
}
*/
