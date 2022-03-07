import SwiftUI

struct SearchView: View {
    
    @StateObject var albums: Albums = Albums()
    
    var body: some View {
            VStack{
                Image("albums")
                    .resizable()
                
                VStack {
                    SuperTextField(placeholder: Text(albums.placeholderText).foregroundColor(.gray), text: $albums.searchText)
                        .padding()
                        .textCase(.lowercase)
                        .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                        .cornerRadius(30)
                        .foregroundColor(.black)
                    
                    Picker("", selection: $albums.selected) {
                        Text("Search By: ")
                        ForEach(albums.searchOptions, id: \.self) {
                            Text($0).font(.subheadline)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .background(Color.gray)

                    NavigationLink(destination: ResultsView(albums: albums)) {
                        Text("Search")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(10)
                    }
                }
                .padding()

            }
            .navigationTitle("AlbumFinder")
            .padding()
    }
}
