//
//  ContentView.swift
//  Game Project
//
//  Created by Nathania McKenzie on 6/24/24.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationStack {
            VStack{
                Text("WELCOME ")
                    .font(.title)
                    .foregroundColor(Color("#3d85c6ff"))
                
                Text("WELCOME ")
                    .font(.body)
                    .foregroundColor(Color(red: 0.8313725490196079, green: 0.9215686274509803, blue: 1.0))
                    .padding(.horizontal, 25.0)
                ZStack{
                    Image("seaheart")
                        .resizable()
                        .padding(.all, 20)
                    

                    Button("Start Reading") {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                    .border(Color.black, width: 40)
                    
                    .padding(.top, 450.0)
                }
                
            }
            .background((Color("#d4ebff")))

                    .toolbar {
                        NavigationLink(destination: Home()) {
                            Text("Home")
                                .underline()
                            
                        }
                        NavigationLink(destination: Library()) {
                            Text("Library")
                                
                                .underline()
                        }
                        NavigationLink(destination: About()) {
                            Text("About")
                                
                                .underline()
                        }
                        NavigationLink(destination: Contact()) {
                            Text("Contact")
                               
                                .underline()
                        }

                    }
                    .background((Color("#d4ebff")))

                   
        }
    }

}

#Preview {
    Home()
}
