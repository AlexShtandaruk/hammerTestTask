import UIKit

final class MovieListLocationTableViewCell: UITableViewCell {
    
    // MARK: - IDENTIFIER CELL
    
    static let identifier = "MovieListLocationTableViewCell"
    
    // MARK: - UI
    
    private let titleLabel = CLabel()
    private let arrowImageView = CImageView()
    
    // MARK: - PROPERTIES
    
    private lazy var subView = [ titleLabel, arrowImageView ]
    
    // MARK: - CONSTRAINT
    
    private lazy var factor = contentView.bounds.width / 5
    
    // MARK: - SET UI METHOD'S
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        contentView.backgroundColor = CColor.background
        
        titleLabel.createLabel(
            text: "Moscow",
            fontType: FontType.morserattRegular.value,
            fontSize: factor/4,
            textColor: CColor.mainBlack,
            textAligment: .left
        )
        titleLabel.sizeToFit()
        arrowImageView.createImageView(
            cornerRadius: 0,
            contentMode: .scaleAspectFit
        )
        arrowImageView.image = UIImage(named: ProjectConstant.ProjectImages.arrow)
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
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spasing),
            
            arrowImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: spasing/3),
            arrowImageView.heightAnchor.constraint(equalToConstant: spasing/2),
            arrowImageView.widthAnchor.constraint(equalToConstant: spasing/1.5),
        ])
    }
}

