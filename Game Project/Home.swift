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
            .toolbar {
                ToolbarItemGroup {
                    NavigationLink(destination: Library()) {
                        Text("Library")
                    }
                    NavigationLink(destination: About()) {
                        Text("About")
                    }
                    NavigationLink(destination: Contact()) {
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
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var message: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Contact Us")
                .font(.title)
                .padding(.bottom, 10)

            Text("Please fill out the form below if you have any questions or feedback.")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.bottom, 20)

            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 15)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 15)

            TextEditor(text: $message)
                .frame(height: 150)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                .padding(.horizontal, 15)

            Button(action: {
                // Action to handle form submission (e.g., sending feedback)
                print("Submit button tapped")
                // Implement logic to handle user input
            }) {
                Text("Submit")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 15)

            Spacer()
        }
        .padding()
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
