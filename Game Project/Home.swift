//
//  ContentView.swift
//  Game Project
//
//  Created by Nathania McKenzie on 6/24/24.
//
import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("WELCOME")
                    .font(.title)
                    .foregroundColor(Color.blue) // Set color to dark blue

                Text("Welcome to our app!")
                    .font(.body)
                    .foregroundColor(Color(red: 0.8313725490196079, green: 0.9215686274509803, blue: 1.0))
                    .padding(.horizontal, 25.0)

                ZStack {
                    Image("seaheart")
                        .resizable()
                        .padding(.all, 20)

                    NavigationLink(destination: Library()) {
                        Text("Start Reading")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.top, 450.0)
                }
            }
            .background(Color(#colorLiteral(red: 0.831372549, green: 0.9215686275, blue: 1, alpha: 1))) // Light blue background color

            .navigationTitle("Home")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        // Action for Library
                    }) {
                        Text("Library")
                    }
                }
                ToolbarItem {
                    Button(action: {
                        // Action for About
                    }) {
                        Text("About")
                    }
                }
                ToolbarItem {
                    Button(action: {
                        // Action for Contact
                    }) {
                        Text("Contact")
                    }
                }
            }
        }
        .tabItem {
            Label("Home", systemImage: "house")
        }
    }
}

struct Library: View {
    var body: some View {
        Text("Library View")
            .navigationTitle("Library")
    }
}

struct About: View {
    var body: some View {
        Text("About View")
            .navigationTitle("About")
    }
}

struct Contact: View {
    var body: some View {
        Text("Contact View")
            .navigationTitle("Contact")
    }
}

struct OpenedBook: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Your Story Title")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Here goes the full story content. You can extend this area to show the entire text of your stories.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
            }
        }
        .navigationTitle("Opened Book")
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
