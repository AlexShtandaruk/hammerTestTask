import Foundation

enum Genre: String, CodingKey, CaseIterable {
    
    case all
    case animation = "Animation"
    case adventure = "Adventure"
    case drama = "Drama"
}
