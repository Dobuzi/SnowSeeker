//
//  ContentView.swift
//  SnowSeeker
//
//  Created by 김종원 on 2020/11/14.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    
    let resorts: [Resort] = Resort.allResorts
    var body: some View {
        NavigationView {
            List(resorts) { resort in
                NavigationLink(
                    destination: ResortView(resort: resort)) {
                    Label(
                        title: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(resort.name)
                                        .font(.headline)
                                    Text("\(resort.runs) runs")
                                        .foregroundColor(.secondary)
                                }
                                .layoutPriority(1)
                                Spacer()
                                if self.favorites.contains(resort) {
                                    Image(systemName: "heart.fill")
                                        .accessibility(label: Text("This is a favorite resort"))
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.leading, 20)
                            
                        },
                        icon: {
                            Image(resort.country)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 25)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                                .shadow(radius: 10)
                                .offset(x: 0, y: 10)
                        }
                    )
                }
            }
            .navigationBarTitle("Resorts")
            
            WelcomeView()
        }
        .phoneOnlyStackNavigationViw()
        .environmentObject(favorites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
