import UIKit

final class CImageView: UIImageView {
    
    func createImageView(
        cornerRadius: CGFloat,
        contentMode: UIView.ContentMode
    ) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.contentMode = contentMode
    }
}

