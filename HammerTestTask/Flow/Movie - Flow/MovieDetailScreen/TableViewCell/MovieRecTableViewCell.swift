import UIKit

final class MovieRecTableViewCell: UITableViewCell {
    
    // MARK: - IDENTIFIER
    
    static let identifier = "MovieRecTableViewCell"
    
    // MARK: - UI
    
    private let titleLabel = CLabel()
    private let movieLayout = UICollectionViewFlowLayout()
    private let movieCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - PROPERTIES
    
    private lazy var subView = [ titleLabel, movieCollectionView ]
    
    // MARK: - CONSTRAINT
    
    private lazy var factor = contentView.bounds.width / 5
    
    // MARK: - SET UI
    
    func setUI() {
        
        contentView.backgroundColor = CColor.custBlack
        
        titleLabel.createLabel(
            text: Constant.title.localized(),
            fontType: FontType.monserattBold.value,
            fontSize: factor/4,
            textColor: CColor.custWhite,
            textAligment: .left
        )
        
        movieLayout.minimumLineSpacing = 10
        movieLayout.minimumInteritemSpacing = 10
        movieLayout.scrollDirection = .horizontal
        
        movieCollectionView.backgroundColor = CColor.custBlack
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        movieCollectionView.showsHorizontalScrollIndicator = false
        movieCollectionView.showsVerticalScrollIndicator = false
        movieCollectionView.collectionViewLayout = movieLayout
        movieCollectionView.register(MovieRecCollectionViewCell.self,forCellWithReuseIdentifier: MovieRecCollectionViewCell.identifier)
        
        setView(subView: subView)
        setConstraint()
    }
    
    private func setView(subView: [UIView]) {
        for i in subView { contentView.addSubview(i) }
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: factor/3),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: factor/3),
            
            movieCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            movieCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - extension - UICollectionViewDataSource

extension MovieRecTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieRecCollectionViewCell.identifier,for: indexPath) as! MovieRecCollectionViewCell
        cell.setUI()
        return cell
    }
}

// MARK: - extension - UICollectionViewDelegate

extension MovieRecTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: - extension - UICollectionViewDelegateFlowLayout

extension MovieRecTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = movieCollectionView.bounds.width / 3
        let height = movieCollectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - Constant's

extension MovieRecTableViewCell {
    
    struct Constant {
        static let title = "movieRecTableViewCell.title"
    }
}
