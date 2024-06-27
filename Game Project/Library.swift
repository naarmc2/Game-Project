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
        Book(title: "Cinders", genre: "Bedtime", coverImageName: "moon", blurb: "ADD BLURB/CONTEXT HERE"),
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
                .foregroundColor(Color.blue)
            
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
        .background(
            Image("potentialBackground") 
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
    }
}
struct BookDetailPage: View {
    var book: Book
    @Binding var savedBooks: [Book]
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("back")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack {
                        Image(book.coverImageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 250, height: 300)
                            .padding()
                        
                        Text(book.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue.opacity(0.8))
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
                            NavigationLink(destination: OpenedBookView(bookTitle: book.title, bookContent: getBookContent(book: book))) {
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
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
    func getBookContent(book: Book) -> [String] {
        switch book.title {
        case "Cinders":
            return [
                "feel free to change everything",
                "...",
                "...",
                "...",
                "..."
            ]
        case "Ocean Serenity":
            return [
                "Coral, a brave young girl, sets out to find her missing father in the vast ocean...",
                "She encounters various sea creatures and faces dangerous storms...",
                "With the help of a friendly dolphin, she discovers an underwater city...",
                "In the city, she learns about her father's whereabouts and the mystery of his disappearance...",
                "Coral finally reunites with her father, bringing peace to their family and the underwater world."
            ]
        case "Romeo and Juliet":
            return [
                "In fair Verona, where we lay our scene, two households, both alike in dignity...",
                "From ancient grudge break to new mutiny, where civil blood makes civil hands unclean...",
                "A pair of star-crossed lovers take their life, whose misadventured piteous overthrows...",
                "Do with their death bury their parents' strife. The fearful passage of their death-marked love...",
                "And the continuance of their parents' rage, which, but their children's end, naught could remove."
            ]
        case "Hamlet":
            return [
                "Prince Hamlet is deeply troubled by the recent death of his father...",
                "He encounters the ghost of his father, who reveals that he was murdered by Hamlet's uncle...",
                "Hamlet feigns madness to investigate the truth and contemplates revenge...",
                "A play is staged to catch the conscience of the king, revealing the guilt of Hamlet's uncle...",
                "In a tragic ending, Hamlet avenges his father's death but loses his own life in the process."
            ]
        case "Harry Potter":
            return [
                "Harry Potter, a young wizard, discovers his magical heritage on his eleventh birthday...",
                "At Hogwarts School of Witchcraft and Wizardry, he makes friends and enemies...",
                "He learns about the dark wizard Voldemort who killed his parents...",
                "With the help of his friends, Harry faces numerous challenges and mysteries...",
                "In the end, he confronts Voldemort, setting the stage for an epic battle between good and evil."
            ]
        case "The Hobbit":
            return [
                "Bilbo Baggins, a hobbit, is reluctantly swept into an epic quest...",
                "He joins a group of dwarves to reclaim their mountain home and treasure from the dragon Smaug...",
                "Along the way, Bilbo encounters trolls, goblins, and other dangers...",
                "He discovers a mysterious ring that grants him invisibility...",
                "With courage and cleverness, Bilbo plays a crucial role in the success of the quest."
            ]
        case "Pride and Prejudice":
            return [
                "Elizabeth Bennet, an intelligent and spirited young woman, navigates the social pressures of 19th century England...",
                "She encounters the proud and wealthy Mr. Darcy, and they initially clash...",
                "Through misunderstandings and revelations, Elizabeth learns of Darcy's true character...",
                "Darcy helps Elizabeth's family in their time of need, changing her opinion of him...",
                "Ultimately, they overcome their pride and prejudice to find love and happiness together."
            ]
        case "Jane Eyre":
            return [
                "Jane Eyre, an orphaned girl, faces hardship and cruelty from a young age...",
                "She grows up to be a strong and independent woman, finding work as a governess...",
                "Jane falls in love with her employer, Mr. Rochester, who harbors a dark secret...",
                "Their relationship is tested by revelations and moral dilemmas...",
                "Jane's resilience and integrity lead her to a fulfilling and just resolution."
            ]
        default:
            return ["This is the default content for books without a specific story."]
        }
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

