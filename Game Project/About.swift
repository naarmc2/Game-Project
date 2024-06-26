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
                Text(" About Childish Wonder ✩" )
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hue: 0.557, saturation: 0.883, brightness: 0.723)) // Set color to dark blue
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(hue: 0.567, saturation: 0.473, brightness: 0.907))
                
                Text("Childish Wonders strives to inspire readers and help writers worldwide grow. We offer reading opportunities designed for today's youth, with stories short enough to capture attention while delivering meaningful moral messages.")
                    .font(.body)
                    .padding(.horizontal, 10.0)
                
                Text("Childish Wonders also aims to provide job opportunities for writers and graphic designers globally.")
                    .font(.body)
                    .padding(.horizontal, 10.0)

                VStack(alignment: .center, content: {
                    Image("shark")
                        .resizable()
                        .padding(.all, 20)
                })
            
                    
                    
                
                
                Spacer()
            }
            
            .padding()
        }
        .background(Color(#colorLiteral(red: 0.831372549, green: 0.9215686275, blue: 1, alpha: 1))) // Light blue background color

        .navigationTitle("About")
    }
}

struct AboutChildishWonders_Previews: PreviewProvider {
    static var previews: some View {
        AboutChildishWonders()
    }
}
