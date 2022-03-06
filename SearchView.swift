import SwiftUI

struct SearchView: View {
    
    @StateObject var albums: Albums = Albums()
    
    var body: some View {
            ZStack{
                Image("albums")
                    .resizable()
                
                VStack {
                    TextField(albums.placeholderText, text: $albums.searchText)
                        .padding()
                        .textCase(.lowercase)
                        .background(Color.white)
                        .cornerRadius(30)
                    
                    Picker("", selection: $albums.selected) {
                        Text("Search By: ")
                        ForEach(albums.searchOptions, id: \.self) {
                            Text($0).font(.subheadline)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .background(Color.white)

                    NavigationLink("Search", destination: ResultsView(albums: albums))
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .font(.headline)
                        .cornerRadius(10)
                }

            }
            .navigationTitle("AlbumFinder")
            .padding()
    }
}
