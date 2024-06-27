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
    var bookTitle: String
    var bookContent: [String]

    var body: some View {
        ZStack {
            Image("potentialBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 20) {
                    Text(bookTitle)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()

                    if isTranslated {
                        Text(translatedText)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else {
                        Text(bookContent[currentPhase - 1])
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding()
                    }

                    if currentPhase < bookContent.count {
                        HStack(spacing: 20) {
                            Button(action: {
                                nextPhase(choice: 1)
                            }) {
                                Text("Choice 1")
                                    .font(.headline)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }

                            Button(action: {
                                nextPhase(choice: 2)
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
                .padding()
            }
        }
        .navigationTitle(bookTitle)
    }

    func nextPhase(choice: Int) {
        
        currentPhase += 1
    }
}

struct OpenedBookView_Previews: PreviewProvider {
    static var previews: some View {
        OpenedBookView(bookTitle: "Sample Title", bookContent: ["Phase 1", "Phase 2", "Phase 3", "Phase 4", "Phase 5"])
    }
}
