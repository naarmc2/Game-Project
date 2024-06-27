//
//  OpenedBook.swift
//  Game Project
//
//  Created by Nathania McKenzie on 6/25/24.
//

import SwiftUI

struct OpenedBookView: View {
    @State private var isTranslated = false
    @State private var translatedText: String = ""
    @State private var currentPhase = 1
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("The Journey of the Lost Ruby")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                if isTranslated {
                    Text(translatedText)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    Text(storyText(phase: currentPhase))
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                if currentPhase <= 5 {
                    HStack(spacing: 20) {
                        Button(action: {
                            self.nextPhase(choice: 1)
                        }) {
                            Text("Choice 1")
                                .font(.headline)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            self.nextPhase(choice: 2)
                        }) {
                            Text("Choice 2")
                                .font(.headline)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
                
                Button(action: {
                    // Toggle between translated and original text
                    if isTranslated {
                        translatedText = ""
                    } else {
                        translatedText = "Translated text will be shown here."
                    }
                    isTranslated.toggle()
                }) {
                    Image(systemName: isTranslated ? "textformat.alt" : "globe")
                        .font(.title)
                }
                .padding()
                
                Spacer()
            }
        }
        .navigationTitle("The Journey of the Lost Ruby")
    }
    
    func storyText(phase: Int) -> String {
        switch phase {
        case 1:
            return "Once upon a time, in a mystical forest, there lived a young adventurer named Alina. She was known for her courage and kindness."
        case 2:
            return "One day, while exploring the depths of the forest, Alina stumbled upon a hidden cave. Inside, she found an ancient map that led to the legendary Lost Ruby."
        case 3:
            return "As Alina ventured deeper into the cave, she encountered a wise old wizard who offered her a choice: take the ruby and face great peril, or leave it and save the forest from darkness."
        case 4:
            return "With her heart pounding, Alina made her decision. She took the ruby, braving treacherous traps and fierce guardians."
        case 5:
            return "In the end, Alina emerged victorious, clutching the Lost Ruby in her hands. She returned to the village as a hero, forever remembered for her bravery and wisdom."
        default:
            return ""
        }
    }
    
    func nextPhase(choice: Int) {
        // Simulate different story branches based on user choice
        switch currentPhase {
        case 1:
            currentPhase = choice == 1 ? 2 : 3
        case 2:
            currentPhase = choice == 1 ? 4 : 3
        case 3:
            currentPhase = choice == 1 ? 4 : 5
        case 4:
            currentPhase = 5
        default:
            break
        }
    }
}

struct OpenedBookView_Previews: PreviewProvider {
    static var previews: some View {
        OpenedBookView()
    }
}
