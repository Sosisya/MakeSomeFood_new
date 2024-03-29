import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let screenSaver = ScreensaverViewController()
        screenSaver.completionHandler = { [weak self, weak window] in
            window?.rootViewController = self?.configureTabBar()
        }
        window.rootViewController = screenSaver
        self.window = window
        window.makeKeyAndVisible()
    }

    func configureTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.tabBar.tintColor = UIColor(named: "orange")
        tabBar.tabBar.unselectedItemTintColor = UIColor(named: "black")
        tabBar.viewControllers = [
            configureHomeController(),
            configureSearchController(),
            configureFavouritesController(),
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

    func configureSearchController() -> UIViewController {
        let searchVC = SearchCollectionViewController(collectionViewLayout: SearchCompositionalLayout())
        let searchNavVC = UINavigationController(rootViewController: searchVC)
        configureNavigationController(searchNavVC)
        searchNavVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        return searchNavVC
    }

    func configureFavouritesController() -> UIViewController {
        let favouritesNavVC = UINavigationController(rootViewController: FavouritesTableViewController())
        configureNavigationController(favouritesNavVC)
        favouritesNavVC.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "heart"), tag: 3)
        return favouritesNavVC
    }

    func configureNavigationController(_ navVC: UINavigationController) {
        navVC.navigationBar.standardAppearance = .standard
        navVC.navigationBar.scrollEdgeAppearance = .scrollEdge
    }
}

extension UINavigationBarAppearance {
    static var standard: UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .font: UIFont(name: "Montserrat-SemiBold", size: 24),
            .foregroundColor: UIColor(named: "black")
        ]
        return appearance
    }

    static var scrollEdge: UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            .font: UIFont(name: "Montserrat-SemiBold", size: 24),
            .foregroundColor: UIColor(named: "black")
        ]
        return appearance
    }
}

