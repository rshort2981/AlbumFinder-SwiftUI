import SwiftUI

struct ResultsView: View {
    
    @ObservedObject var albums: Albums

    var body: some View {
        List {
            ForEach(albums.results, id: \.collectionId) { item in
                VStack(alignment: .leading) {
                    HStack {
                        Image(uiImage: item.artworkUrl100.load())
                            .frame(width: 50, height: 50)
                            .padding()
                        Spacer()
                        Text(item.collectionName)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .multilineTextAlignment(.trailing)
                            .padding()
            
                        Button(action: {
                            _ = albums.getId(id: item.collectionId)
                            albums.goToView.toggle()
                        }) {
                            Image(systemName: "cursorarrow.click")
                                .foregroundColor(Color.blue)
                        }.sheet(isPresented: $albums.goToView, onDismiss: albums.getAlbums) {
                            AlbumView(albums: albums)
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear(perform: albums.getAlbums)
        .navigationTitle("Albums")
    }
}
