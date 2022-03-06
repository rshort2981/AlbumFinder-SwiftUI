//
import Foundation
import SwiftUI

class Albums: ObservableObject {
    
    @Published var results = [Result]()
    @Published var searchText = ""
    @Published var collectionID = 0
    
    var searchOptions = ["Artist", "Album", "Song"]
    @Published var selected = "Artist"
    
    @Published var goToView = false
    
    var placeholderText: String {
        var text = ""
        
        switch selected {
        case "Artist":
            text = "Enter artist..."
        case "Album":
            text = "Enter album..."
        case "Song":
            text = "Enter song..."
        default: break
        }
        
        return text
    }
    
    func getAlbums() {
        var url = URL(string: "https://itunes.apple.com/search?term=\(searchText.replacingOccurrences(of: " ", with: "+", options: .caseInsensitive))&attribute=artistTerm&entity=album")
        
        switch selected {
            case searchOptions[0]:
                url = URL(string: "https://itunes.apple.com/search?term=\(searchText.replacingOccurrences(of: " ", with: "+", options: .caseInsensitive))&attribute=artistTerm&entity=album")
            case searchOptions[1]:
                url = URL(string: "https://itunes.apple.com/search?term=\(searchText.replacingOccurrences(of: " ", with: "+", options: .caseInsensitive))&attribute=albumTerm&entity=album")
            case searchOptions[2]:
                url = URL(string: "https://itunes.apple.com/search?term=\(searchText.replacingOccurrences(of: " ", with: "+", options: .caseInsensitive))&attribute=songTerm&entity=song")
            default: break
        }

        downloadData(fromURL: url!) { (returnedData) in
            if let data = returnedData {
                guard let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.results = decodedResponse.results
                }
            } else {
                print("No data returned.")
            }
        }
    }
    
    func getSongs() {
        
        guard let url = URL(string: "https://itunes.apple.com/lookup?id=\(getId(id: collectionID))&entity=song") else { return }
        
        downloadData(fromURL: url) { (returnedData) in
            if let data = returnedData {
                guard let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.results = decodedResponse.results
                }
            } else {
                print("No data returned.")
            }
        }
    }
    
    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data  = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error downloading data.")
                completionHandler(nil)
                return
            }
            
            completionHandler(data)
            
//            let jsonString = String(data: data, encoding: .utf8)
//            print(jsonString)
            
        }.resume()
    }
    
    func getId(id: Int) -> Int {
        collectionID = id
        return collectionID
    }
}
