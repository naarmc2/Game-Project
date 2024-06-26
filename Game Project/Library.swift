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
    // You can add more properties like coverImageURL if you have images to display
}

struct LibraryPage: View {
    // Example list of books
    let books = [
        Book(title: "Harry Potter and the Sorcerer's Stone", genre: "Fantasy"),
        Book(title: "The Hobbit", genre: "Fantasy"),
        Book(title: "Romeo and Juliet", genre: "Drama"),
        Book(title: "Hamlet", genre: "Drama"),
        Book(title: "Pride and Prejudice", genre: "Romance"),
        Book(title: "Jane Eyre", genre: "Romance"),
        Book(title: "Add Title", genre: "Bedtime"),
        Book(title: "Add Titlee", genre: "Bedtime"),
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
                                            // Placeholder for cover image (you can replace with actual images if available)
                                            Rectangle()
                                                .fill(Color.gray)
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
                .navigationTitle("Library")
            }
        }
    }
}

struct BookDetailPage: View {
    var book: Book
    
    var body: some View {
        VStack {
            // Placeholder for cover image (you can replace with actual image if available)
            Rectangle()
                .fill(Color.gray)
                .frame(width: 250, height: 300) // Adjust size as needed
            
            Text(book.title)
                .font(.title)
                .foregroundColor(.black)
                .multilineTextAlignment(.center) // Center align title
                .padding()
            
            Text("Genre: \(book.genre)")
                .font(.headline)
                .foregroundColor(.gray)
                .padding()
            
            Spacer()
        }
        .navigationTitle(book.title)
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
