import UIKit

// MARK: - Watch button delegate TableView cell did selected

protocol WatchTableViewCellDidSelected: AnyObject {
    
    func watchTableViewCellDidSelected()
}

final class WatchTableViewCell: UITableViewCell {
    
    // MARK: - IDENTIFIER
    
    static let identifier = "WatchTableViewCell"
    
    // MARK: - UI
    
    private let watchButton = CButton()
    
    // MARK: - PROPERTIES
    
    weak var delegate: WatchTableViewCellDidSelected?
    private lazy var subView = [ watchButton ]
    
    // MARK: - CONSTRAINT
    
    private lazy var factor = contentView.bounds.width / 5
    
    // MARK: - SET UI

    func setUI() {
        
        contentView.backgroundColor = CColor.custBlack
        
        watchButton.createTextButton(
            title: Constant.watch.localized(),
            fontType: FontType.morserattRegular.value,
            fontSize: factor/4,
            backgroundColor: CColor.custRed,
            titleColorNormal: CColor.custWhite,
            titleColorHighlighted: CColor.custDarkGray,
            target: self,
            action: #selector(tappedWatchButton)
        )
        watchButton.layer.cornerRadius = factor/3
        
        setView(subView: subView)
        setConstraint()
    }
    
    private func setView(subView: [UIView]) {
        for i in subView { contentView.addSubview(i) }
    }
    
    private func setConstraint() {
        let spasing = factor / 5
        NSLayoutConstraint.activate([
            watchButton.topAnchor.constraint(equalTo: self.topAnchor, constant: spasing),
            watchButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spasing),
            watchButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spasing),
            watchButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -spasing)
        ])
    }
    
    @objc private func tappedWatchButton() {
        delegate?.watchTableViewCellDidSelected()
    }
}

// MARK: - Constant's

extension WatchTableViewCell {
    
    struct Constant {
        static let watch = "watchTableViewCell.watch"
    }
}
