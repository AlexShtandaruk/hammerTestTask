import UIKit

final class MovieListCollectionView: UITableViewCell {
    
    // MARK: - IDENTIFIER
    
    static let identifier = "MovieListCollectionView"
    
    // MARK: - UI
    
    private let movieLayout = UICollectionViewFlowLayout()
    private let movieCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout())
    
    var data: [Movie] = [] {
        didSet {
            movieCollectionView.reloadData()
        }
    }
    
    // MARK: - PROPERTIES
    
    private lazy var subView = [ movieCollectionView ]
    
    // MARK: - CONSTRAINT
    
    private lazy var factor = contentView.bounds.width / 5
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        contentView.backgroundColor = CColor.background
        
        movieLayout.minimumLineSpacing = 20
        movieLayout.minimumInteritemSpacing = 20
        movieLayout.scrollDirection = .horizontal
        
        movieCollectionView.backgroundColor = CColor.background
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        movieCollectionView.showsHorizontalScrollIndicator = false
        movieCollectionView.showsVerticalScrollIndicator = false
        movieCollectionView.collectionViewLayout = movieLayout
        movieCollectionView.register(MovieListCollectionViewCell.self,forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
        
        setView(subView: subView)
        setConstraint()
    }
    
    private func setView(subView: [UIView]) {
        for i in subView { contentView.addSubview(i) }
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            movieCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            movieCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - extension - UICollectionViewDataSource

extension MovieListCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier,for: indexPath) as! MovieListCollectionViewCell
        let data = data[indexPath.row]
        cell.setUI(imageLink: data.poster ?? "")
        return cell
    }
}

// MARK: - extension - UICollectionViewDelegate

extension MovieListCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: - extension - UICollectionViewDelegateFlowLayout

extension MovieListCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = movieCollectionView.bounds.width / 1.2 - 20
        let height = movieCollectionView.bounds.height - 10
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
}

// MARK: - Constant's

extension MovieListCollectionView {
    
    struct Constant {
        static let title = "movieRecTableViewCell.title"
    }
}
