import UIKit

final class MovieDetailTableViewCell: UITableViewCell {
    
    // MARK: - IDENTIFIER
    
    static let identifier = "MovieDetailTableViewCell"
    
    // MARK: - UI
    
    private let movieContainerView = CView()
    private let movieImageView = CImageView()
    private let titleLabel = CLabel()
    private let yearLabel = CLabel()
    private let runtimeLabel = CLabel()
    private let descriptionLabel = CLabel()
    private let actorLabel = CLabel()
    private let directorLabel = CLabel()
    private let startWatchButton = CButton()
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
    private let factor: CGFloat = 100
    private lazy var imageSize = factor * 2
    private lazy var subView: [UIView] = [
        movieContainerView,
        movieActivityIndicator,
        movieImageView,
        titleLabel,
        yearLabel,
        runtimeLabel,
        descriptionLabel,
        actorLabel,
        directorLabel,
        startWatchButton
    ]
    
    // MARK: - SET UI
    
    func setUI(
        image: String?,
        title: String?,
        year: String?,
        runtime: String?,
        descriptionMovie: String?,
        actor: String?,
        director: String?
    ) {
        
        let labelArray = [yearLabel, runtimeLabel, actorLabel, directorLabel, descriptionLabel]
        let actorTexts = [Constant.actorTakePart.localized(), " ",  (actor ?? "") ]
        let directorTexts = [Constant.directorTakePart.localized(), " ",  (director ?? "") ]
        let descriptionTexts = [Constant.descriptionAboutMovie.localized(), " ",  (descriptionMovie ?? "") ]
        let colors = [ CColor.custRed, .clear, CColor.custLightGray]
        
        for label in labelArray {
            label.createLabel(
                text: nil,
                fontType: FontType.morserattRegular.value,
                fontSize: factor/8,
                textColor: CColor.custLightGray,
                textAligment: .left)
        }
        
        self.backgroundColor = CColor.custBlack
        
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 2
        titleLabel.createLabel(
            text: title,
            fontType: FontType.monserattBold.value,
            fontSize: factor/5,
            textColor: CColor.custRed,
            textAligment: .left
        )
        yearLabel
            .text = (year ?? "") + " " + Constant.year.localized()
        runtimeLabel
            .text = runtime
        actorLabel.lineBreakMode = .byWordWrapping
        actorLabel.numberOfLines = 2
        actorLabel.attributedText = actorLabel.getAttributedString(
            arrayText: actorTexts,
            arrayColors: colors
        )
        directorLabel.attributedText = directorLabel.getAttributedString(
            arrayText: directorTexts,
            arrayColors: colors
        )
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 4
        descriptionLabel.attributedText = descriptionLabel.getAttributedString(
            arrayText: descriptionTexts,
            arrayColors: colors
        )
        movieContainerView.createView(
            cornerRadius: 0
        )
        movieImageView.createImageView(
            cornerRadius: imageSize / 5,
            contentMode: .scaleToFill
        )
        movieActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        movieActivityIndicator.startAnimating()
        movieActivityIndicator.isHidden = false
        movieActivityIndicator.color = .white
        
        fetchImage(
            imageLink: image
        )
        setView(
            subView: subView
        )
        setConstraint()
    }
    
    private func setView(subView: [UIView]) {
        for i in subView { self.addSubview(i) }
    }
    
    private func setConstraint() {
        
        let spasing = factor / 6
        
        NSLayoutConstraint.activate([
            movieContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spasing),
            movieContainerView.heightAnchor.constraint(equalToConstant: imageSize),
            movieContainerView.widthAnchor.constraint(equalToConstant: imageSize/1.5),
            
            movieImageView.topAnchor.constraint(equalTo: movieContainerView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: movieContainerView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: movieContainerView.trailingAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: movieContainerView.bottomAnchor),
            
            movieActivityIndicator.centerXAnchor.constraint(equalTo: movieContainerView.centerXAnchor),
            movieActivityIndicator.centerYAnchor.constraint(equalTo: movieContainerView.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: movieContainerView.trailingAnchor, constant: spasing),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spasing),
            titleLabel.heightAnchor.constraint(equalToConstant: factor/1.5),

            runtimeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            runtimeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            runtimeLabel.trailingAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            runtimeLabel.heightAnchor.constraint(equalToConstant: factor/5),

            yearLabel.topAnchor.constraint(equalTo: runtimeLabel.topAnchor),
            yearLabel.leadingAnchor.constraint(equalTo: runtimeLabel.trailingAnchor),
            yearLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            yearLabel.bottomAnchor.constraint(equalTo: runtimeLabel.bottomAnchor),

            actorLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor),
            actorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            actorLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            actorLabel.heightAnchor.constraint(equalToConstant: factor/2.5),

            directorLabel.topAnchor.constraint(equalTo: actorLabel.bottomAnchor),
            directorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            directorLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            directorLabel.heightAnchor.constraint(equalToConstant: factor/3.5),

            descriptionLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
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

// MARK: - Constant's

extension MovieDetailTableViewCell {
    
    struct Constant {
        static let actorTakePart = "movieDetailView.actorTakePart"
        static let directorTakePart = "movieDetailView.directorTakePart"
        static let descriptionAboutMovie = "movieDetailView.descriptionAboutMovie"
        static let year = "movieDetailView.year"
    }
}
