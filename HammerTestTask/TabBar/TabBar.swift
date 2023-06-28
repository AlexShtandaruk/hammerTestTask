import UIKit

final class TabBarController: UITabBarController {
    
    private lazy var factor = view.bounds.width/5
    
    var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
        setTabBarAppearence()
        selectedIndex = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        tabBar.frame.size.height = view.frame.width/4.5
        tabBar.frame.origin.y = view.frame.size.height - view.frame.width/4.5
    }
    
    private func setTabBar() {
        viewControllers = [
            generateVC(viewController: viewController,
                       name: Constant.menu.localized(),
                       image: UIImage(named: ProjectConstant.ProjectImages.menu)),
            generateVC(viewController: ViewController(),
                       name: Constant.contact.localized(),
                       image: UIImage(named: ProjectConstant.ProjectImages.location)),
            generateVC(viewController: ViewController(),
                       name: Constant.profile.localized(),
                       image: UIImage(named: ProjectConstant.ProjectImages.profile)),
            generateVC(viewController: ViewController(),
                       name: Constant.cart.localized(),
                       image: UIImage(named: ProjectConstant.ProjectImages.cart))
        ]
    }
    
    private func generateVC(viewController: UIViewController, name: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = name
        viewController.tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont(
                name: "Montserrat-Regular",
                size: factor/6.5)!],
            for: .normal)
        viewController.tabBarItem.image = image
        viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        return viewController
    }

    private func setTabBarAppearence() {
        tabBar.tintColor = CColor.mainPink
        tabBar.unselectedItemTintColor = CColor.mainGray
        tabBar.backgroundColor = CColor.mainWhite
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = CColor.background.cgColor
        tabBar.itemPositioning = .fill
    }
}

// MARK: - Constant's

extension TabBarController {
    struct Constant {
        static var menu = "tabBarController.menu"
        static var contact = "tabBarController.contact"
        static var profile = "tabBarController.profile"
        static var cart = "tabBarController.cart"
    }
}


