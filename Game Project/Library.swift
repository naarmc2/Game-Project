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
        Book(title: "Harry Potter and the Sorcerer's Stone", genre: "Fantasy", coverImageName: "mysticCat", blurb: "ADD BLURB/CONTEXT HERE"),
        Book(title: "The Hobbit", genre: "Fantasy", coverImageName: "flowers", blurb: "ADD BLURB/CONTEXT HERE"),
        Book(title: "Romeo and Juliet", genre: "Drama", coverImageName: "jellyfish", blurb: "ADD BLURB/CONTEXT HERE"),
        Book(title: "Hamlet", genre: "Drama", coverImageName: "shark", blurb: "ADD BLURB/CONTEXT HERE"),
        Book(title: "Pride and Prejudice", genre: "Romance", coverImageName: "planet", blurb: "ADD BLURB/CONTEXT HERE"),
        Book(title: "Jane Eyre", genre: "Romance", coverImageName: "sky", blurb: "ADD BLURB/CONTEXT HERE"),
        Book(title: "Title", genre: "Bedtime", coverImageName: "moon", blurb: "ADD BLURB/CONTEXT HERE"),
        Book(title: "Add Title", genre: "Bedtime", coverImageName: "boat", blurb: "ADD BLURB/CONTEXT HERE"),
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
                                                    .foregroundColor(.black)
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
                .padding()
            
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
