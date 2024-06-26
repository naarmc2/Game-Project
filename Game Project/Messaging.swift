//
//  Messaging.swift
//  Game Project
//
//  Created by Angela on 6/26/24.
//

import SwiftUI

struct Messaging: View {
    @State private var messages: [Message] = []
    @State private var newMessageText: String = ""
    @State private var senderName: String = ""
    
    var body: some View {
        ZStack {
            // Background image
            Image("back")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Messaging")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Image(systemName: "message")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding()
                    .foregroundColor(.blue)
                
                Text("Connect with your friends!")
                    .font(.body)
                    .padding()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(messages, id: \.id) { message in
                            MessageView(message: message)
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: 300, maxHeight: 300)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                VStack {
                    TextField("Your Name", text: $senderName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    TextField("Type your message", text: $newMessageText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: sendMessage) {
                        Text("Send")
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(20)
                    }
                    .padding(.top)
                }
                .padding()
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Messaging")
    }
    
    private func sendMessage() {
        guard !newMessageText.isEmpty, !senderName.isEmpty else { return }
        
        let message = Message(id: UUID(), sender: senderName, text: newMessageText)
        messages.append(message)
        
        // Clear the message text field after sending
        newMessageText = ""
    }
}

struct MessageView: View {
    var message: Message
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(message.sender):")
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Text(message.text)
                .padding(10)
                .foregroundColor(.black)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
        }
    }
}

struct Message: Identifiable {
    var id: UUID
    var sender: String
    var text: String
}

struct Messaging_Previews: PreviewProvider {
    static var previews: some View {
        Messaging()
    }
}
