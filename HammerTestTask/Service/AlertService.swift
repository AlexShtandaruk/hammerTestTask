import UIKit

enum AlertEvent {
    case failureNetwork
    case tryToWatchMovie
}

final class AlertService {
    
    let alert = CAlertController()
    
    func alertForUser(
        with type: AlertEvent,
        view: UIViewController,
        text: String?,
        code: Int?
    ) {
        switch type {
        case .failureNetwork:
            alert.openAlert(
                viewController: view,
                title: Constant.title.localized(),
                message: Constant.failure.localized() + " " + (text ?? "") + " " + Constant.statusCode.localized() + String(code ?? Int()),
                alertStyle: .alert,
                actionTitles: [ Constant.cancel.localized() ],
                actionStyles: [ .cancel ],
                actions: [ { _ in print("failureNetwork")} ]
            )
        case .tryToWatchMovie:
            alert.openAlert(
                viewController: view,
                title: Constant.title.localized(),
                message: Constant.tryToWatch.localized(),
                alertStyle: .alert,
                actionTitles: [ Constant.cancel.localized() ],
                actionStyles: [ .cancel ],
                actions: [ { _ in print("tryToWatchMovie")} ]
            )
        }
    }
}

extension AlertService {
    struct Constant {
        static let failure = "alertService.failure"
        static let statusCode = "alertService.statusCode"
        static let cancel = "alertService.cancel"
        static let title = "alertService.title"
        static let tryToWatch = "alertService.tryToWatch"
    }
}
