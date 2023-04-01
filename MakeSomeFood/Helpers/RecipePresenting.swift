import Foundation
import UIKit

protocol RecipePresenting: UIViewController {
    func showRecipe(_ recipe: Recipe)
    func showRecipes(_ tagType: TagsType, _ tag: String)
}

extension RecipePresenting {
    func showRecipe(_ recipe: Recipe) {
        let recipeVC = CookingViewController()
        recipeVC.recipe = recipe
        if navigationController != nil {
            show(recipeVC, sender: self)
        } else {
            let navigationVC = UINavigationController(rootViewController: recipeVC)
            show(navigationVC, sender: self)
        }
    }

    func showRecipes(_ tagType: TagsType, _ tag: String) {
        let recipesOfCategoriesVC = RecipesOfCategoryTableViewController()
        show(recipesOfCategoriesVC, sender: self)
        recipesOfCategoriesVC.tagsType = tagType
        recipesOfCategoriesVC.categoryName = tag
    }
}
