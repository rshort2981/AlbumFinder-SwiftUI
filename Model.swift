import Foundation

// Albums
struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var collectionId: Int
    var collectionName: String
    var artworkUrl100: String
    var trackName: String?
    var trackId: Int?
    var collectionViewUrl: String?
}
