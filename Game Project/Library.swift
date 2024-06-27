//
//  Library.swift
//  Game Project
//
//  Created by Nathania McKenzie on 6/25/24.
//

import SwiftUI

// Define a Book struct to hold book information
struct Book {
    var title: String
    var genre: String
    var coverImageName: String // Property for cover image name
    var blurb: String // Property for book blurb
}

struct LibraryPage: View {
    // Example list of books
    let books = [
        Book(title: "Harry Potter", genre: "Fantasy", coverImageName: "harry", blurb: "Unbridled magic & sorcery. Do you dare to tread further?"),
        Book(title: "The Hobbit", genre: "Fantasy", coverImageName: "hobbit", blurb: "Short men who make big differences in a medivial setting."),
        Book(title: "Romeo and Juliet", genre: "Drama", coverImageName: "swan", blurb: "Not even deathly dispute can quell the love between the next heirs of Montague and Capulet families"),
        Book(title: "Hamlet", genre: "Drama", coverImageName: "hamlet", blurb: "Is blood really thicker than water? Prince Hamlet can tell you all about that..."),
        Book(title: "Pride and Prejudice", genre: "Romance", coverImageName: "planet", blurb: "Don't let your pride stop you from being with the love of your life. One life, one chance, don't waste it"),
        Book(title: "Jane Eyre", genre: "Romance", coverImageName: "sky", blurb: "Feminisim at its core! No one can stop a woman hard at work."),
        Book(title: "Title", genre: "Bedtime", coverImageName: "moon", blurb: "ADD BLURB/CONTEXT HERE"),
        Book(title: "Ocean Serenity", genre: "Bedtime", coverImageName: "boat", blurb: "Sea torrents and hurricanes cannot stop this girl from finding her missing father. Follow the journey of Coral as she dives into deep waters and discovers a whole new world under the sea."),
        // Add more books as needed
    ]
    
    @State private var searchText = ""
    
    var filteredBooks: [Book] {
        if searchText.isEmpty {
            return books
        } else {
            return books.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.genre.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var groupedBooks: [String: [Book]] {
        Dictionary(grouping: filteredBooks, by: { $0.genre })
    }
    
    var genres: [String] {
        groupedBooks.keys.sorted()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("potentialBackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    SearchBar(text: $searchText)
                    
                    ScrollView {
                        ForEach(genres, id: \.self) { genre in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(genre)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                    .padding(.top, 20)
                                
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                                    ForEach(groupedBooks[genre]?.prefix(2) ?? [], id: \.title) { book in
                                        NavigationLink(destination: BookDetailPage(book: book)) {
                                            VStack {
                                                // Cover Image based on book's coverImageName
                                                Image(book.coverImageName)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 150, height: 200) // Adjust size as needed
                                                
                                                Text(book.title)
                                                    .font(.headline)
                                                    .foregroundColor(Color(hue: 0.557, saturation: 0.954, brightness: 0.952))
                                                    .multilineTextAlignment(.center) // Center align title
                                                    .padding(.horizontal, 10)
                                                    .frame(maxWidth: 150) // Limit width for alignment
                                            }
                                            .padding(.bottom, 20) // Add padding below each book item
                                        }
                                        .buttonStyle(PlainButtonStyle()) // Remove default button styling
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Library") // Set navigation title directly
            .foregroundColor(Color(hue: 0.557, saturation: 0.949, brightness: 0.7))
        }
    }
}

struct BookDetailPage: View {
    var book: Book
    
    var body: some View {
        VStack {
            // Display the cover image
            Image(book.coverImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 300) // Adjust size as needed
                .padding()
            
            // Display book details
            Text(book.title)
                .font(.title)
                .foregroundColor(.black)
                .multilineTextAlignment(.center) // Center align title
                .padding()
            
            Text("Genre: \(book.genre)")
                .font(.headline)
                .foregroundColor(.gray)
                .padding()
            
            // Display book blurb
            Text(book.blurb)
                .font(.body)
                .foregroundColor(.black)
                .multilineTextAlignment(.center) // Center align blurb
                .fixedSize(horizontal: false, vertical: true)


            
            // Button to open full book details
            NavigationLink(destination: OpenedBook()) {
                Text("Read Full Book")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.top, 20)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(book.title) // Set navigation title to book title
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search books", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: {
                text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
        }
    }
}

struct LibraryPage_Previews: PreviewProvider {
    static var previews: some View {
        LibraryPage()
    }
}
