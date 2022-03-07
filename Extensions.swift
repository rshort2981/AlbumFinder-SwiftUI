import SwiftUI

extension String {
    
    func load() -> UIImage {
        
        do {
            guard let url = URL(string: self) else { return UIImage() }
            let data: Data = try Data(contentsOf: url)
            return UIImage(data: data) ?? UIImage()
            
        } catch {
            //
        }
        return UIImage()
    }
}

struct SuperTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->()  = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}
