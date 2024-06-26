//
//  OpenedBook.swift
//  Game Project
//
//  Created by Nathania McKenzie on 6/25/24.
//

import SwiftUI

struct OpenedBookView: View {
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

struct OpenedBookView_Previews: PreviewProvider {
    static var previews: some View {
        OpenedBookView()
    }
}
