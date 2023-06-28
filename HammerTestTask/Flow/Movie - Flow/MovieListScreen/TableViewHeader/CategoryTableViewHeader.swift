import UIKit

// MARK: - Movie list delegate TableView group did selected

protocol CategoryTableViewGroupDidSelected: AnyObject {
    func didSelectedModel(genre: Genre?)
}

// MARK: - Movie list TableView header

final class CategoryTableViewHeader: UIView {
    
    // MARK: - UI
    
    private let containerView = CView()
    private let groupCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private let groupLayout = UICollectionViewFlowLayout()
    
    // MARK: - PROPERTIES
    
    private let data = Genre.allCases
    weak var delegate: CategoryTableViewGroupDidSelected?
    
    // MARK: - CONSTRAINT
    
    private lazy var factor: CGFloat = 10
    
    // MARK: - SET UI
    
    func setUI() -> UIView {
        
        containerView.backgroundColor = CColor.background
        containerView.createView(
            cornerRadius: 0
        )
        groupLayout.minimumLineSpacing = 10
        groupLayout.minimumInteritemSpacing = 10
        groupLayout.scrollDirection = .horizontal
        
        groupCollectionView.backgroundColor = CColor.background
        groupCollectionView.dataSource = self
        groupCollectionView.delegate = self
        groupCollectionView.translatesAutoresizingMaskIntoConstraints = false
        groupCollectionView.showsHorizontalScrollIndicator = false
        groupCollectionView.showsVerticalScrollIndicator = false
        groupCollectionView.collectionViewLayout = groupLayout
        groupCollectionView.register(
            GroupCollectionViewCell.self,
            forCellWithReuseIdentifier: GroupCollectionViewCell.identifier
        )
        
        setView()
        setConstraint()
        
        return self
    }
    
    // MARK: - SET VIEW
    
    private func setView() {
        self.addSubview(containerView)
        containerView.addSubview(groupCollectionView)
    }
    
    // MARK: - CONSTRAINT
    
    private func setConstraint() {
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            groupCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            groupCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            groupCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            groupCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - extension - UICollectionViewDataSource

extension CategoryTableViewHeader: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCollectionViewCell.identifier, for: indexPath) as! GroupCollectionViewCell
        let currentData = data[indexPath.row]
        cell.setUI(text: .getGenreName(genre: currentData))
        return cell
    }
}

// MARK: - extension - UICollectionViewDelegate

extension CategoryTableViewHeader: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectedModel(genre: data[indexPath.row])
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
    }
}

// MARK: - extension - UICollectionViewDelegateFlowLayout

extension CategoryTableViewHeader: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = groupCollectionView.bounds.height - 40
        let width = groupCollectionView.bounds.width / 3.5 - 20
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: 20, bottom: 40, right: 20)
    }
}

// MARK: - Constant's

extension CategoryTableViewHeader {
    struct Constant {
        static let title = "categoryTableViewHeader.title"
    }
}
