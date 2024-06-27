//
//  Library.swift
//  Game Project
//
//  Created by Nathania McKenzie on 6/25/24.
//

import SwiftUI

struct Book: Identifiable {
    var id = UUID()
    var title: String
    var genre: String
    var coverImageName: String
    var blurb: String
}

struct LibraryPage: View {
    @State private var searchText = ""
    @State private var savedBooks: [Book] = []
    
    let books = [
        Book(title: "Harry Potter", genre: "Fantasy", coverImageName: "harry", blurb: "Unbridled magic & sorcery. Do you dare to tread further?"),
        Book(title: "The Hobbit", genre: "Fantasy", coverImageName: "hobbit", blurb: "Short men who make big differences in a medieval setting."),
        Book(title: "Romeo and Juliet", genre: "Drama", coverImageName: "swan", blurb: "Not even deathly dispute can quell the love between the next heirs of Montague and Capulet families."),
        Book(title: "Hamlet", genre: "Drama", coverImageName: "hamlet", blurb: "Is blood really thicker than water? Prince Hamlet can tell you all about that..."),
        Book(title: "Pride and Prejudice", genre: "Romance", coverImageName: "planet", blurb: "Don't let your pride stop you from being with the love of your life. One life, one chance, don't waste it."),
        Book(title: "Jane Eyre", genre: "Romance", coverImageName: "sky", blurb: "Feminism at its core! No one can stop a woman hard at work."),
        Book(title: "Title", genre: "Bedtime", coverImageName: "moon", blurb: "ADD BLURB/CONTEXT HERE"),
        Book(title: "Ocean Serenity", genre: "Bedtime", coverImageName: "boat", blurb: "Sea torrents and hurricanes cannot stop this girl from finding her missing father. Follow the journey of Coral as she dives into deep waters and discovers a whole new world under the sea."),
    ]
    
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
                                    ForEach(groupedBooks[genre] ?? [], id: \.id) { book in
                                        NavigationLink(destination: BookDetailPage(book: book, savedBooks: $savedBooks)) {
                                            VStack {
                                                Image(book.coverImageName)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 150, height: 200)
                                                
                                                Text(book.title)
                                                    .font(.headline)
                                                    .foregroundColor(Color(hue: 0.557, saturation: 0.954, brightness: 0.952))
                                                    .multilineTextAlignment(.center)
                                                    .padding(.horizontal, 10)
                                                    .frame(maxWidth: 150)
                                            }
                                            .padding(.bottom, 20)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Library")
            .foregroundColor(Color(hue: 0.557, saturation: 0.949, brightness: 0.7))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SavedLibraryPage(savedBooks: $savedBooks)) {
                        Image(systemName: "bookmark.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}

struct SavedLibraryPage: View {
    @Binding var savedBooks: [Book]
    
    var body: some View {
        VStack {
            Text("Saved Books")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            ScrollView {
                ForEach(savedBooks, id: \.id) { book in
                    NavigationLink(destination: BookDetailPage(book: book, savedBooks: $savedBooks)) {
                        VStack {
                            Image(book.coverImageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 200)
                            
                            Text(book.title)
                                .font(.headline)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 10)
                                .frame(maxWidth: 150)
                        }
                        .padding(.bottom, 20)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .navigationTitle("Saved Books")
    }
}

struct BookDetailPage: View {
    var book: Book
    @Binding var savedBooks: [Book]
    
    var body: some View {
        ScrollView {
            VStack {
                Image(book.coverImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 300)
                    .padding()
                
                Text(book.title)
                    .font(.title)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("Genre: \(book.genre)")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
                
                Text(book.blurb)
                    .font(.body)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                
                HStack {
                    NavigationLink(destination: OpenedBook()) {
                        Text("Read Full Book")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.top, 20)
                    }
                    
                    Button(action: {
                        if !savedBooks.contains(where: { $0.id == book.id }) {
                            savedBooks.append(book)
                        }
                    }) {
                        Text("Save to My Library")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding(.top, 20)
                    }
                }
            }
            .padding()
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
