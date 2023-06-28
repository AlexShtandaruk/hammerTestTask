import UIKit
import AnimationForTestProject

final class LogInViewController: UIViewController {
    
    // MARK: - UI
    
    private let loginTextField = CTextField()
    private let passwordTextField = CTextField()
    private let logInButton = CButton()
    private let signInButton = CButton()
    private let resetPasswordButton = CButton()
    private let alertLabel = CLabel()
    
    // MARK: - PROPERTIES
    
    var presenter: LogInPresenterProtocol!
    internal var correctLogin: Bool = true
    internal var correctPassword: Bool = true
    private lazy var subView: [UIView] = [
        loginTextField,
        passwordTextField,
        logInButton,
        signInButton,
        resetPasswordButton,
        alertLabel
    ]
    
    // MARK: - CONSTRAINT
    
    private lazy var factor = view.bounds.width / 5
    private lazy var heightTextField = factor / 2
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        textFieldDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - ACTION'S
    
    @objc private func tappedLogInButton(sender: UIButton) {
        AnimationForTestProject().basicButtonAnimation(sender)
        presenter.checkValidation(
            login: loginTextField.text ?? String(),
            password: passwordTextField.text ?? String()
        )
    }
    
    @objc private func tappedSignInButton(sender: UIButton) {
        AnimationForTestProject().basicButtonAnimation(sender)
        presenter.userWantToSignIn()
    }
    
    @objc private func tappedForgetPasswordButton() {
        presenter.userForgotPassword()
    }
    
    // MARK: - ALERT SETTING'S
    
    private func alertDisappear() {
        UIView.animate(withDuration: 3.0) {
            self.correctLogin = true
            self.correctPassword = true
            self.alertLabel.alpha = 0
            self.changeTextFieldColor()
        }
    }
    
    private func changeTextFieldColor() {
        switch correctLogin {
        case true:
            loginTextField.layer.borderColor = CColor.custRed.cgColor
        case false:
            loginTextField.layer.borderColor = CColor.custBlue.cgColor
        }
        switch correctPassword {
        case true:
            passwordTextField.layer.borderColor = CColor.custRed.cgColor
        case false:
            passwordTextField.layer.borderColor = CColor.custBlue.cgColor
        }
    }
}

// MARK: - extension - LogInViewProtocol

extension LogInViewController: LogInViewProtocol {
    
    func success() {
        presenter.userLogIn()
    }
    
    func error(message: String) {
        alertLabel.text = message
        changeTextFieldColor()
        alertLabel.alpha = 1
        alertDisappear()
    }
}

// MARK: - extension - ViewControllerProtocol

extension LogInViewController: ViewControllerProtocol {
    
    func setUI() {
        view.backgroundColor = CColor.custBlack
        
        loginTextField.createTextField(
            fontSize: factor/6,
            backgroundColor: CColor.clear,
            cornerRadius: heightTextField/2,
            borderColor: CColor.custRed.cgColor,
            borderWidth: 1,
            textColor: CColor.custRed,
            placeholderText: Constant.logintf.localized(),
            placeholderColor: CColor.custDarkGray
        )
        passwordTextField.isSecureTextEntry = true
        passwordTextField.createTextField(
            fontSize: factor/6,
            backgroundColor: CColor.clear,
            cornerRadius: heightTextField/2,
            borderColor: CColor.custRed.cgColor,
            borderWidth: 1,
            textColor: CColor.custRed,
            placeholderText: Constant.passwordtf.localized(),
            placeholderColor: CColor.custDarkGray
        )
        logInButton.layer.cornerRadius = heightTextField / 2
        logInButton.createTextButton(
            title: Constant.logInbt.localized(),
            fontType: FontType.morserattRegular.value,
            fontSize: factor/5,
            backgroundColor: CColor.custRed,
            titleColorNormal: CColor.custBlack,
            titleColorHighlighted: CColor.custDarkGray,
            target: self,
            action: #selector(tappedLogInButton)
        )
        signInButton.layer.cornerRadius = heightTextField / 2
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = CColor.custRed.cgColor
        signInButton.createTextButton(
            title: Constant.signInbt.localized(),
            fontType: FontType.monserattBold.value,
            fontSize: factor/5,
            backgroundColor: CColor.clear,
            titleColorNormal: CColor.custRed,
            titleColorHighlighted: CColor.custDarkGray,
            target: self,
            action: #selector(tappedSignInButton)
        )
        resetPasswordButton.createTextButton(
            title: Constant.resetPasswordbt.localized(),
            fontType: FontType.morserattRegular.value,
            fontSize: factor/7,
            backgroundColor: .clear,
            titleColorNormal: CColor.custWhite,
            titleColorHighlighted: CColor.custDarkGray,
            target: self,
            action: #selector(tappedForgetPasswordButton)
        )
        alertLabel.backgroundColor = CColor.custBlue
        alertLabel.layer.cornerRadius = heightTextField/2
        alertLabel.alpha = 0
        alertLabel.createLabel(
            text: nil,
            fontType: FontType.morserattRegular.value,
            fontSize: factor/6,
            textColor: CColor.custBlack,
            textAligment: .center
        )
        setView(view: view, subView: subView)
        setConstraint()
    }
    
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: factor/2),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -factor/2),
            loginTextField.heightAnchor.constraint(equalToConstant: heightTextField),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: factor/4),
            passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: heightTextField),
            
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: factor/4),
            logInButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: heightTextField),
            
            signInButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: factor/4),
            signInButton.leadingAnchor.constraint(equalTo: logInButton.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: logInButton.trailingAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: heightTextField),
            
            resetPasswordButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: factor/4),
            resetPasswordButton.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor, constant: factor),
            resetPasswordButton.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor, constant: -factor),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: heightTextField/1.5),
            
            alertLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: factor),
            alertLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: factor),
            alertLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -factor),
            alertLabel.heightAnchor.constraint(equalToConstant: heightTextField),
        ])
    }
}

// MARK: - extension - UITextFieldDelegate

extension LogInViewController: UITextFieldDelegate {
    
    private func textFieldDelegate() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTextField:
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            textField.resignFirstResponder()
            presenter.checkValidation(
                login: loginTextField.text ?? String(),
                password: passwordTextField.text ?? String()
            )
        default:
            break
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
}

// MARK: - Сonstant's

extension LogInViewController {
    
    struct Constant {
        
        static let logintf = "logInViewController.logintf"
        static let passwordtf = "logInViewController.passwordtf"
        static let logInbt = "logInViewController.logInbt"
        static let signInbt = "logInViewController.signInbt"
        static let resetPasswordbt = "logInViewController.resetPasswordbt"
    }
}
