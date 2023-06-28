//
//  ModuleBuilder.swift
//  MVP+Unit
//
//  Created by Alex Shtandaruk on 28.04.2023.
//

import UIKit


protocol AssemblyBuilderBuilderProtocol {
    
    static func createMainModule() -> UIViewController
    
    static func createDetailModule(data: Dota?) -> UIViewController
}

class AssemblyModuleBuiler: AssemblyBuilderBuilderProtocol {
    
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    static func createDetailModule(data: Dota?) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view, networkService: networkService, data: data)
        view.presenter = presenter
        return view
    }
}
