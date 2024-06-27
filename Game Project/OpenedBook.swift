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
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Your Story Title")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                if isTranslated {
                    Text(translatedText)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    Text("Here goes the full story content. You can extend this area to show the entire text of your stories.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                Button(action: {
                    // Simulate translation for demonstration
                    if isTranslated {
                        translatedText = "Here goes the full story content. You can extend this area to show the entire text of your stories."
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
        .navigationTitle("Opened Book")
    }
}

struct OpenedBookView_Previews: PreviewProvider {
    static var previews: some View {
        OpenedBookView()
    }
}
