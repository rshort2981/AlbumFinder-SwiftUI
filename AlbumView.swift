import SwiftUI

struct AlbumView: View {
    
    @ObservedObject var albums: Albums

    var body: some View {
        
        Image(systemName: "xmark.circle")
            .padding()
            .foregroundColor(.red)
            .onTapGesture {
                albums.goToView = false
            }
            .font(.title)
            .offset(x: 125)
        
        List {
            ForEach(albums.results, id: \.trackId) { item in
                let albumName = item.collectionName
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.trackName ?? "ALBUM: \(albumName)")
                            .font(.headline)
                        Text(item.collectionName)
                            .font(.footnote)
                    }
                    
                    Link("Go to iTunes", destination: URL(string: "\(item.collectionViewUrl ?? "")")!)
                        .font(.footnote)
                        .foregroundColor(Color.blue)
                }
            }
        }
        .onAppear(perform: albums.getSongs)
        .navigationTitle("Songs")
    }
}
