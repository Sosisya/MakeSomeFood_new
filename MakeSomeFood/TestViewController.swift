import UIKit

class TestViewController: UIViewController {

    private let recipeView: RecipeCardView = {
        let recipeView = RecipeCardView()
        recipeView.translatesAutoresizingMaskIntoConstraints = true
        return recipeView
    }()

    private let textFieldView: TextFieldView = {
        let textField = TextFieldView()
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupConstraints()
    }
}

extension TestViewController {
    func setupLayout() {
        view.addSubview(textFieldView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            textFieldView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

import SwiftUI
struct ListProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
            .previewDevice("iPhone 14 Pro Max")
            .previewDisplayName("iPhone 14 Pro Max")
    }

    struct ContainterView: UIViewControllerRepresentable {
        let listVC = TestViewController()
        func makeUIViewController(context:
                                  UIViewControllerRepresentableContext<ListProvider.ContainterView>) -> TestViewController {
            return listVC
        }

        func updateUIViewController(_ uiViewController:
                                    ListProvider.ContainterView.UIViewControllerType, context:
                                    UIViewControllerRepresentableContext<ListProvider.ContainterView>) {
        }
    }
}
