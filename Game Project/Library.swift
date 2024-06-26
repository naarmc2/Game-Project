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
        Book(title: "Pride and Prejudice", genre: "Romance"),
        Book(title: "To Kill a Mockingbird", genre: "Classic"),
        Book(title: "1984", genre: "Dystopian"),
        Book(title: "The Catcher in the Rye", genre: "Literary Fiction")
        // Add more books as needed
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                    ForEach(books, id: \.title) { book in
                        NavigationLink(destination: BookDetailPage(book: book)) {
                            VStack(alignment: .leading, spacing: 8) {
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

                                Text(book.genre)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center) // Center align genre
                                    .padding(.horizontal, 10)
                                    .frame(maxWidth: 150) // Limit width for alignment
                            }
                        }
                        .buttonStyle(PlainButtonStyle()) // Remove default button styling
                    }
                }
                .padding()
            }
            .navigationTitle("Library")
        }
    }
}

struct BookDetailPage: View {
    var book: Book
    
    var body: some View {
        VStack {
            Text(book.title)
                .font(.title)
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

struct LibraryPage_Previews: PreviewProvider {
    static var previews: some View {
        LibraryPage()
    }
}
