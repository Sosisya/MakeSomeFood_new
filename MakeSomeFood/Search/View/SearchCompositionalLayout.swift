import UIKit

class SearchCompositionalLayout: UICollectionViewCompositionalLayout {

    enum Section: Int, CaseIterable {
        case category
        case area
        case ingredient
        case allRecipes
    }

    private struct Spec {
        static var chipsItemSizeWidth: CGFloat = 1
        static var chipsItemSizeHeight: CGFloat = 200
        static var chipsGroupLayoutSizeWidth = 1.0
        static var chipsGroupInterItemSpacing: CGFloat = 0
        static var chipsSectionContentInsetsTop: CGFloat = 10
        static var chipsSectionContentInsetsLeading: CGFloat = 0
        static var chipsSectionContentInsetsTrailing: CGFloat = 0
        static var chipsSectionContentInsetsBottom: CGFloat = 16
        static var chipsSectionInterGroupSpacing: CGFloat = 0
        static var chipsFooterHeaderSizeWidth = 1.0
        static var chipsFooterHeaderSizeHeight = 42.0
        static var recipeItemSizeWidth: CGFloat = 100
        static var recipeItemSizeHeight: CGFloat = 100
        static var recipeGroupLayoutSizeWidth = 1.0
        static var recipeGroupInterItemSpacing: CGFloat = 8
        static var recipeSectionContentInsetsTop: CGFloat = 10
        static var recipeSectionContentInsetsLeading: CGFloat = 16
        static var recipeSectionContentInsetsTrailing: CGFloat = 16
        static var recipeSectionContentInsetsBottom: CGFloat = 16
        static var recipeSectionInterGroupSpacing: CGFloat = 12
        static var recipeFooterHeaderSizeWidth = 1.0
        static var recipeFooterHeaderSizeHeight = 42.0
    }

    private static func createLayout() -> ((Int, NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection?) {

        return { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            if sectionKind == .allRecipes {
                return createRecipeLayout(sectionIndex: sectionIndex, layoutEnvironment: layoutEnvironment)
            } else {
                return createChipsLayout(sectionIndex: sectionIndex, layoutEnvironment: layoutEnvironment)
            }
        }
    }

    private static func createChipsLayout(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(Spec.chipsItemSizeWidth),
            heightDimension: .estimated(Spec.chipsItemSizeHeight)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(Spec.recipeGroupLayoutSizeWidth),
                heightDimension: itemSize.heightDimension
            ),  subitems: [.init(layoutSize: itemSize)])
        group.interItemSpacing = .fixed(Spec.recipeGroupInterItemSpacing)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: Spec.recipeSectionContentInsetsTop, leading: Spec.recipeSectionContentInsetsLeading, bottom: Spec.recipeSectionContentInsetsBottom, trailing: Spec.recipeSectionContentInsetsTrailing)
        section.interGroupSpacing = Spec.recipeSectionInterGroupSpacing

        let footerHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Spec.recipeFooterHeaderSizeWidth),
            heightDimension: .absolute(Spec.recipeFooterHeaderSizeHeight)
        )

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        return section
    }

    private static func createRecipeLayout(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Spec.chipsItemSizeWidth),
            heightDimension: .estimated(Spec.chipsItemSizeHeight)
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .fractionalWidth(Spec.chipsGroupLayoutSizeWidth),
                heightDimension: itemSize.heightDimension
            ),  subitems: [.init(layoutSize: itemSize)])
        group.interItemSpacing = .fixed(Spec.chipsGroupInterItemSpacing)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: Spec.chipsSectionContentInsetsTop, leading: Spec.chipsSectionContentInsetsLeading, bottom: Spec.chipsSectionContentInsetsBottom, trailing: Spec.chipsSectionContentInsetsTrailing)
        section.interGroupSpacing = Spec.chipsSectionInterGroupSpacing

        let footerHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Spec.chipsFooterHeaderSizeWidth),
            heightDimension: .absolute(Spec.chipsFooterHeaderSizeHeight)
        )

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        return section
    }

    init() {
        super.init(sectionProvider: SearchCompositionalLayout.createLayout())

    }

    required init?(coder: NSCoder) {
        super.init(sectionProvider: SearchCompositionalLayout.createLayout())
    }
}
