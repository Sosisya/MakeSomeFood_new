import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

struct FavouritesManager {

    static let ref = Database.database(url: "https://makesomefood2-default-rtdb.firebaseio.com/").reference()
    static var favouritesHandle: UInt?
    static var favourites = [Recipe]()

    static func addFavourite(_ recipe: Recipe) {
        guard let userId = Auth.auth().currentUser?.uid else {
            showAuth {
                addFavourite(recipe)
            }
            return
        }
        ApiManager().getRecipeById(id: recipe.id) { result in
            switch result {
            case .success(let recipeList):
                ref.child("users/\(userId)/favourites/\(recipe.id)").setValue(recipeList.meals[0].mapToDict())
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    static func getFavourites(completion: @escaping ([Recipe]) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion([])
            return
        }
        let favouritesRef = ref.child("users/\(userId)/favourites")
        if let favouritesHandle {
            favouritesRef.removeObserver(withHandle: favouritesHandle)
        }
        favouritesHandle = favouritesRef.observe(.value) { snapshot in
            guard let favourites = snapshot.value as? NSDictionary else {
                completion([])
                return
            }
            let favouritesArray: [Recipe] = favourites.allValues.compactMap {
                guard let recipeDict = $0 as? NSDictionary else { return nil }
                return Recipe(dict: recipeDict)
            }
            FavouritesManager.favourites = favouritesArray
            completion(favouritesArray)
        }
    }

    static func isFavourite(recipeId: String, completion: @escaping (Bool) -> Void) -> (DatabaseReference?, UInt?) {
        guard let userId = Auth.auth().currentUser?.uid else { return (nil, nil) }
        let recipeRef = ref.child("users/\(userId)/favourites/\(recipeId)")
        let refHandle = recipeRef.observe(DataEventType.value, with: { snapshot in
            completion(snapshot.exists())
        })
        return (recipeRef, refHandle)
    }

    static func cancelFavouriteSubscription(_ dataBaseRef: DatabaseReference, _ refHandle: UInt) {
        dataBaseRef.removeObserver(withHandle: refHandle)
    }

    static func removeFavourites(recipeId: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let recipeRef = ref.child("users/\(userId)/favourites/\(recipeId)")
        recipeRef.removeValue()
    }

    static private func showAuth(_ onAuth: @escaping () -> Void) {
        let topVC = topViewController()
        let authVC = LoginViewController()
        let authNavVC = UINavigationController(rootViewController: authVC)
        authVC.onAuthAction = { [weak authNavVC] in
            onAuth()
            authNavVC?.dismiss(animated: true)
        }
        topVC?.present(authNavVC, animated: true)
    }

    static func topViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        } else {
            return nil
        }
    }
}

