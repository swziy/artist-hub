import UIKit

struct ListViewLayoutConfigurator {

    static var makeLayout: UICollectionViewLayout {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .estimated(88.0))

        let item = NSCollectionLayoutItem(layoutSize: size)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12.0, bottom: 0, trailing: 12.0)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20.0
        section.contentInsets = NSDirectionalEdgeInsets(top: 20.0, leading: 0, bottom: 12.0, trailing: 0)
        section.boundarySupplementaryItems = [makeHeaderLayout]

        return UICollectionViewCompositionalLayout(section: section)
    }

    // MARK: - Private

    static var makeHeaderLayout: NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: size,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)

        return header
    }
}
