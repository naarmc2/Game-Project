//
//  About.swift
//  Game Project
//
//  Created by Nathania McKenzie on 6/25/24.
//

import SwiftUI

struct AboutChildishWonders: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("About Childish Wonders")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Childish Wonders strives to inspire readers and help writers worldwide grow. We offer reading opportunities designed for today's youth, with stories short enough to capture attention while delivering meaningful moral messages.")
                    .font(.body)
                
                Text("Childish Wonders also aims to provide job opportunities for writers and graphic designers globally.")
                    .font(.body)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("About")
    }
}

struct AboutChildishWonders_Previews: PreviewProvider {
    static var previews: some View {
        AboutChildishWonders()
    }
}
