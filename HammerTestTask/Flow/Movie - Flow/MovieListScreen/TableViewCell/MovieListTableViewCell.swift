import UIKit

final class MovieListTableViewCell: UITableViewCell {
    
    // MARK: - IDENTIFIER CELL
    
    static let identifier = "CategoryTableViewCell"
    
    // MARK: - UI
    
    private let titleLabel = CLabel()
    private let plotLabel = CLabel()
    private let durationLabel = CLabel()
    private let movieImageView = CImageView()
    private let movieConteinerView = CView()
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
    private lazy var subView = [
        titleLabel,
        plotLabel,
        durationLabel,
        movieConteinerView,
        movieImageView,
        movieActivityIndicator
    ]
    
    // MARK: - CONSTRAINT
    
    private lazy var factor = contentView.bounds.width / 5
    private lazy var imageSize = factor * 2.2
    
    // MARK: - SET UI METHOD'S
    
    func setUI(radius: CGFloat, title: String?, plot: String?, duration: String?, imageLink: String?) {
        
        
        contentView.layer.cornerRadius = radius
        
        titleLabel.createLabel(
            text: title,
            fontType: FontType.monserattBold.value,
            fontSize: factor/4,
            textColor: CColor.mainBlack,
            textAligment: .left
        )
        
        plotLabel.createLabel(
            text: plot,
            fontType: FontType.morserattRegular.value,
            fontSize: factor/5,
            textColor: CColor.mainGray,
            textAligment: .left
        )
        
        durationLabel.createLabel(
            text: duration,
            fontType: FontType.morserattRegular.value,
            fontSize: factor/5,
            textColor: CColor.mainPink,
            textAligment: .center
        )
        
        fetchImage(
            imageLink: imageLink
        )
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        contentView.backgroundColor = CColor.mainWhite
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        movieActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        movieActivityIndicator.startAnimating()
        movieActivityIndicator.isHidden = false
        movieActivityIndicator.color = .white
        
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 2
        
        plotLabel.lineBreakMode = .byWordWrapping
        plotLabel.numberOfLines = 4
        
        durationLabel.layer.cornerRadius = 7
        durationLabel.layer.borderColor = CColor.mainPink.cgColor
        durationLabel.layer.borderWidth = 1
        
        movieConteinerView.createView(
            cornerRadius: 0
        )
        movieImageView.createImageView(
            cornerRadius: imageSize / 2,
            contentMode: .scaleToFill
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
        
        let spasing = factor / 3
        
        NSLayoutConstraint.activate([
            movieConteinerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieConteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spasing),
            movieConteinerView.heightAnchor.constraint(equalToConstant: imageSize),
            movieConteinerView.widthAnchor.constraint(equalToConstant: imageSize),
            
            movieImageView.topAnchor.constraint(equalTo: movieConteinerView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: movieConteinerView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: movieConteinerView.trailingAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: movieConteinerView.bottomAnchor),
            
            movieActivityIndicator.centerXAnchor.constraint(equalTo: movieConteinerView.centerXAnchor),
            movieActivityIndicator.centerYAnchor.constraint(equalTo: movieConteinerView.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: movieConteinerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: movieConteinerView.trailingAnchor, constant: spasing),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spasing),
            titleLabel.heightAnchor.constraint(equalToConstant: spasing),
           
            plotLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spasing/1.5),
            plotLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            plotLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            plotLabel.heightAnchor.constraint(equalToConstant: spasing * 3),
            
            durationLabel.topAnchor.constraint(equalTo: plotLabel.bottomAnchor, constant: spasing/1.5),
            durationLabel.leadingAnchor.constraint(equalTo: plotLabel.centerXAnchor),
            durationLabel.trailingAnchor.constraint(equalTo: plotLabel.trailingAnchor),
            durationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spasing),
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

// MARK: - Сonstant's

extension MovieListTableViewCell {
    struct Constant {
        static let year = "movieListTableViewCell.year"
        static let hours = "movieListTableViewCell.hours"
        static let minutes = "movieListTableViewCell.minutes"
        static let duration = "movieListTableViewCell.duration"
    }
}
