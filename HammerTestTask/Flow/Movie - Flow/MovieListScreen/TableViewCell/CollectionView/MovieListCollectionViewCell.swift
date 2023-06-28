import UIKit

final class MovieListCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IDENTIFIER
    
    static let identifier = "MovieListCollectionViewCell"
    
    //MARK: - UI
    
    private let movieContainerView = CView()
    private let movieImageView = CImageView()
    private let movieActivityIndicator = UIActivityIndicatorView()
    private var movieImage: UIImage? {
        didSet {
            movieImageView.image = movieImage
            movieActivityIndicator.stopAnimating()
            movieActivityIndicator.isHidden = true
        }
    }
    
    // MARK: - PROPERTIES
    
    private let networkService = NetworkService()
    private lazy var subView = [ movieContainerView, movieActivityIndicator, movieImageView ]
    
    //MARK: - CONSTRAINT
    
    private let factor: CGFloat = 10
    
    //MARK: - SET UI
    
    func setUI(imageLink: String) {
        fetchImage(
            imageLink: imageLink
        )
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        movieContainerView.createView(
            cornerRadius: factor*5
        )
        movieContainerView.backgroundColor = CColor.background
        movieImageView.createImageView(
            cornerRadius: factor,
            contentMode: .scaleAspectFill
        )
        setView(
            subView: subView
        )
        setConstraint()
    }
    
    private func setView(subView: [UIView]) {
        for i in subView { contentView.addSubview(i) }
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            movieContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            movieImageView.leadingAnchor.constraint(equalTo: movieContainerView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: movieContainerView.trailingAnchor),
            movieImageView.topAnchor.constraint(equalTo: movieContainerView.topAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: movieContainerView.bottomAnchor),
            
            movieActivityIndicator.centerXAnchor.constraint(equalTo: movieContainerView.centerXAnchor),
            movieActivityIndicator.centerYAnchor.constraint(equalTo: movieContainerView.centerYAnchor)
        ])
    }
    
    // MARK: - Fetch image from model link
    
    private func fetchImage(imageLink: String?) {
        guard let url = URL(string: imageLink ?? String()) else { return }
        networkService.fetchImageData(from: url) { [weak self] image in
            guard let self = self else { return }
            self.movieImage = image
        }
    }
}
