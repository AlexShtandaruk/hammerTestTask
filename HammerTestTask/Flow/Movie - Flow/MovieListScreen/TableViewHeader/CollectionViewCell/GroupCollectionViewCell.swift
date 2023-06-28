import UIKit

final class GroupCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IDENTIFIER
    
    static let identifier = "GroupCollectionViewCell"
    
    //MARK: - UI
    
    private let titleLabel = CLabel()
    private let titleContainerView = CView()
    
    override var isSelected: Bool {
        didSet {
            if isSelected  {
                titleLabel.font = UIFont(name: FontType.monserattBold.value, size: factor*1.2)
                titleLabel.alpha = 1
                titleContainerView.backgroundColor = CColor.mainPink
            } else {
                titleLabel.font = UIFont(name: FontType.morserattRegular.value, size: factor*1.2)
                titleLabel.alpha = 0.4
                titleContainerView.backgroundColor = .clear
            }
        }
    }
    
    //MARK: - CONSTRAINT
    
    private let factor: CGFloat = 10
    
    //MARK: - SET UI
    
    func setUI(text: String) {
        
        titleLabel.createLabel(
            text: text,
            fontType: FontType.morserattRegular.value,
            fontSize: factor*1.2,
            textColor: CColor.mainPink,
            textAligment: .center
        )
    }
    
    // MARK: - SET VIEW
    
    private func setView() {
        contentView.addSubview(titleContainerView)
        contentView.addSubview(titleLabel)
    }
    
    // MARK: - CONSTRAINT
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            titleContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
        ])
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    
        contentView.layer.cornerRadius = factor*3
        
        titleContainerView.createView(
            cornerRadius: self.bounds.height/2
        )
        titleContainerView.backgroundColor = .clear
        titleContainerView.alpha = 0.4
        titleContainerView.layer.borderWidth = 1
        titleContainerView.layer.borderColor = CColor.mainPink.cgColor
        
        titleLabel.alpha = 0.4
        
        setView()
        setConstraint()
    }
}
