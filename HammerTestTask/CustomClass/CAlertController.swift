import UIKit

final class CAlertController: UIAlertController {
    
    func openAlert(
       viewController: UIViewController,
       title: String,
       message: String,
       alertStyle:UIAlertController.Style,
       actionTitles:[String],
       actionStyles:[UIAlertAction.Style],
       actions: [((UIAlertAction) -> Void)]){
           
           let alertController = UIAlertController(
               title: title,
               message: message,
               preferredStyle: alertStyle)
           for (index, indexTitle) in actionTitles.enumerated(){
               let action = UIAlertAction(
                   title: indexTitle,
                   style: actionStyles[index],
                   handler: actions[index])
               alertController.addAction(action)
           }
           viewController.present(alertController,
                                  animated: true)
       }
}
 
