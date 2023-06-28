import UIKit

final class Launcher {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol
    var auth: Bool = false
    
    init(navigationController: UINavigationController?, assemblyBuilder: AssemblyBuilderProtocol, auth: Bool) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
        self.auth = auth
    }
    
    func launch() {
        if auth {
            let router = RouterMovie(navigationController: self.navigationController!, assemblyBuilder: self.assemblyBuilder) {
                self.auth = false
                DataCaretaker.authSave(self.auth)
                let router = RouterAuth(
                    navigationController: self.navigationController!,
                    assemblyBuilder: self.assemblyBuilder,
                    completionAuth: { [weak self] in
                        guard let self = self else { return }
                        self.auth = true
                        DataCaretaker.authSave(self.auth)
                        self.launch()
                    }
                )
                router.initialView()
            }
            router.initialView()
        } else {
            let router = RouterAuth(navigationController: self.navigationController!, assemblyBuilder: self.assemblyBuilder) {
                self.auth = true
                DataCaretaker.authSave(self.auth)
                let router = RouterMovie(
                    navigationController: self.navigationController!,
                    assemblyBuilder: self.assemblyBuilder,
                    completionAuth: { [weak self] in
                        guard let self = self else { return }
                        self.auth = false
                        DataCaretaker.authSave(self.auth)
                        self.launch()
                    }
                )
                router.initialView()
            }
            router.initialView()
        }
    }
}
