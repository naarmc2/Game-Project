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
        Book(title: "Cinders", genre: "Bedtime", coverImageName: "moon", blurb: "An evil stepmother is no match for true love! Claim your glass slipper and enter into royalty."),
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
                    "Once Upon A Time, there lived a child...well, you should know who it is, as it's you! You lived in a large country estate with your distant father...and his 'new family'. Your new stepsisters and stepmother are beautiful of face, yet vile and black of heart. Behind your father's back, they mock you, forcing you to clean up after them, and even force you to clean the fires. They call you cinder-...(Option 1 = Ella OR Option 2 = Ellis)",
                    "Your stepmother is a stark difference to your kind late mother. You miss her dearly, but you have to stay strong for your father. Your father who is going on a business trip soon...one that he asks what you'd like him to bring back. Do you ask for...(Option 1 = A single rose OR Option 2 = The First twig that brushes his hat on his way home)",
                    "Your father returns with your gift and you bury it at your mother's grave. Years pass, and your father along with them. Now, your stepmother and stepsisters rule the house, with you as their designated worker. Thankfully, along with the help of the birds that roost by your mother's grave and the mice that live in the walls of your attic, you are able to spend your days working, less alone. However, you overhear your stepsisters talking...they say the palace is hosting a ball for the royal heir...will you...(Option 1 = Start making a dress for the ball OR Option 2 = Start making a suit for the ball)",
                    "As you work on your outfit, you use remnants of old outfits of your parents and old jewelry of relatives past you found in crevices of the attic long ago. Your outfit is incredible, however it doesn't stay that way long as your stepsisters come upstairs and completely tarnish it; leaving you with nothing to wear. 'You weren't to be invited anyways, cinder-HAHAHAHAHAAH' they chitter at you, leaving you quietly stewing. Your stepmother calls you to the main hall however, and declares that you are to not attend the ball unless you clean the main fireplace of the house...one that your older stepsister just burnt your mother's photograph in. You really want to attend the ball, however, so do you... (Option 1 = Get the mice to help OR Option 2 = Get the birds to help)",
                    "Hearing your cries as the carriage clops away, the creatures lend you a helping paw/wing, and help you pick the fireplace clean. Yet, ready in time for the ball, you realize you are still left without an outfit and left covered in cinders. Running for comfort, you lay by your mother's grave and sob into the ground. Hoping the tears could reach her down there. As you are preoccupied you seem to miss the bright blue light being emitted behind you...is it (Option 1 = Your fairy godparent OR Option 2 = Your deceased mother)",
                    "The glowing being behind you goes on to introduce themselves saying that they'll help you prepare for the ball. They offer you clothing do you wear...(Option 1 = A suit of clouds OR Option 2 = A dress of diamonds)",
                    "To finish off your outfit, you are gifted a pair of glass shoes. Along with your outfit, however, you are granted a carriage, footman, and horses from a pumpkin, frog, and the mice. You are warned that you only have till the clock strikes twelve before you turn back to your old self. Making your way to the ball, the carriage races across the countryside, attempting to get to the ball in time for the entrance ceremonies. You manage to thankfully attend just in time to watch the mysterious royal heir descend the stairs. You are instantly drawn to their regal air, and their eyes; coincidentally, they are drawn the same to you. They find you to ask you to dance...do you (Option 1 = Dance with them proudly OR Option 2 = Dance while attempting to hide your face)",
                    "You dance with them once, then twice, then for the entirety of the ball you stay with them in the core of the dance hall, your heart pounds...due to the fact that you are uncertain whether or not your stepfamily can recognize you. Sure you're all dolled up, but can they still see you as cinder- your thoughts are caught off as you hear the chime of a distant church bell. 'It's time to run', you think. You run out of the hall to the carriages, the young royal right on your heels. You however get stuck on the stairs leaving your...(Option 1 = heel behind OR Option 2 = shoe behind)",
                    "You ignore it however, along with the desperate pleas of your last dance partner, as you gallop away along with the carriage. Almost making it home, you fall flat into the cabbage patch alongside the exterior of the house, leaving your clothes covered in mud. It doesn't matter though, as the carriage, horses, footman, and glittering outfit are all gone. The night was finished and so was your dreams. You go back inside to... (Option 1 = Hide from the stepfamily OR Option 2 = Go to sleep",
                    "The next day, the manor is abuzz; your stepfamily, with suspicion of you, but one that is shadowed by the thoughts of the royal search. Yes, that is right. Your dazzling charmer from last night, took your leftover shoe, and was now entertaining all of the eligible folk of the kingdom to see if their foot would fit your mold. As soon as you hear this though, it's too late as they are just at the door with their footman. They fail to notice you lurking on the stairs, and you watch as they attempt to fit it on each of your step families foots. They grunt and groan, but no matter how hard they try, the shoe just won't fit. As the royal attempts to leave you...(Option 1 = Call out to them OR Option 2 = Run down to them)",
                    "They notice your attempt and as soon as they see your eyes, they know it's you. The shoe fits like a glove, and you run back to the attic to retrieve the matching shoe. The various creatures of the house chitter and cheer for you and the royal as you are promptly escorted to the carriage. There, your true journey will start as the old chapters close and another opens. What will happen next? Read 'Ashes' (a 'Cinders' sequel) to find out more."
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

