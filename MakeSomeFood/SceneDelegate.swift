import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = configureTabBar()
        self.window = window
        window.makeKeyAndVisible()
    }

    func configureTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.tabBar.tintColor = UIColor(named: "orange")
        tabBar.tabBar.unselectedItemTintColor = UIColor(named: "black")
        tabBar.viewControllers = [
            configureHomeController(),
            configureLoginController()
        ]
        return tabBar
    }

    func configureHomeController() -> UIViewController {
        let homeNavVC = UINavigationController(rootViewController: HomeTableViewController())
        configureNavigationController(homeNavVC)
        homeNavVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        return homeNavVC
    }

    func configureLoginController() -> UIViewController {
        let loginNavVC = UINavigationController(rootViewController: LoginViewController())
        configureNavigationController(loginNavVC)
        loginNavVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        return loginNavVC
    }

    func configureNavigationController(_ navVC: UINavigationController) {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes =  [
            .font: UIFont(name: "Montserrat-Medium", size: 17),
            .foregroundColor: UIColor.red
        ]
        navVC.navigationBar.standardAppearance = appearance
        navVC.navigationBar.scrollEdgeAppearance = appearance
    }
}

