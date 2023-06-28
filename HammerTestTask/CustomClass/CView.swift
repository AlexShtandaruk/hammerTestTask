import UIKit

final class CView: UIView {
    
    func createView(
        cornerRadius: CGFloat
    ) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
}
