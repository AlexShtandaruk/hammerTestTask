import UIKit

final class MovieRecCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IDENTIFIER
    
    static let identifier = "MovieRecCollectionViewCell"
    
    //MARK: - CONSTRAINT
    
    private let factor: CGFloat = 10
    
    //MARK: - SET UI
    
    func setUI() {
        
        contentView.backgroundColor = CColor.custDarkGray
        contentView.layer.cornerRadius = factor*2
        setConstraint()
    }
    
    private func setView(subView: [UIView]) {
        for i in subView { contentView.addSubview(i) }
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
        ])
    }
}
