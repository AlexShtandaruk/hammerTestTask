import UIKit
import AnimationForTestProject

// MARK: - Movie list delegate TableView group did selected

protocol MovieDetailTableViewDidSelected: AnyObject {
    
    func didSelectedToTapBack()
    func didSelectedToLogOut()
}

final class MovieDetailTableViewHeader: UIView {
    
    //MARK: - UI
    
    private let containerView = CView()
    private let titleLabel = CLabel()
    private let backButton = CButton()
    private let logOutButton = CButton()
    
    // MARK: - CONSTRAINT
    
    private lazy var factor: CGFloat = 10
    private lazy var buttonHeight = factor * 5
    
    // MARK: - PROPERTIES
    
    let coreAnimation = AnimationForTestProject()
    weak var delegate: MovieDetailTableViewDidSelected?
    private lazy var subView = [
        titleLabel,
        backButton,
        logOutButton
    ]
    
    // MARK: - SET UI
    
    func setUI() -> UIView {
        
        containerView.backgroundColor = CColor.custBlack
        containerView.createView(
            cornerRadius: 0
        )
        titleLabel.createLabel(
            text: Constant.title.localized(),
            fontType: FontType.monserattBold.value,
            fontSize: factor*3,
            textColor: CColor.custWhite,
            textAligment: .center
        )
        backButton.layer.cornerRadius = buttonHeight/2
        backButton.createTextButton(
            title: Constant.backButton.localized(),
            fontType: FontType.monserattBold.value,
            fontSize: factor,
            backgroundColor: CColor.custDarkGray,
            titleColorNormal: CColor.custBlack,
            titleColorHighlighted: CColor.custDarkGray,
            target: self,
            action: #selector(tappedBack)
        )
        logOutButton.layer.cornerRadius = buttonHeight/2
        logOutButton.createTextButton(
            title: Constant.logOutButton.localized(),
            fontType: FontType.monserattBold.value,
            fontSize: factor,
            backgroundColor: CColor.custLightGray,
            titleColorNormal: CColor.custRed,
            titleColorHighlighted: CColor.custDarkGray,
            target: self,
            action: #selector(tappedLogOut)
        )
        setView(subView: subView)
        setConstraint()
        
        return self
    }
    
    // MARK: - SET VIEW
    
    private func setView(subView: [UIView]) {
        self.addSubview(containerView)
        for i in subView { containerView.addSubview(i)}
    }
    
    // MARK: - CONSTRAINT
    
    private func setConstraint() {
        let buttonWidth = buttonHeight * 1.2
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            backButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: factor*2),
            backButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            backButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            
            logOutButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            logOutButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -factor*2),
            logOutButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            logOutButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: factor),
            titleLabel.trailingAnchor.constraint(equalTo: logOutButton.leadingAnchor, constant: -factor),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
   
    //MARK: - ACTION
    
    @objc private func tappedBack(sender: UIButton) {
        coreAnimation.basicButtonAnimation(sender)
        delegate?.didSelectedToTapBack()
    }
    
    @objc private func tappedLogOut(sender: UIButton) {
        coreAnimation.basicButtonAnimation(sender)
        delegate?.didSelectedToLogOut()
    }
}

// MARK: - Constant's

extension MovieDetailTableViewHeader {
    
    struct Constant {
        static let title = "objectTableViewHeader.title"
        static let backButton = "objectTableViewHeader.backButton"
        static let logOutButton = "objectTableViewHeader.logOutButton"
    }
}
