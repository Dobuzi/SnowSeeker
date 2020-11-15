//
//  ContentView.swift
//  SnowSeeker
//
//  Created by 김종원 on 2020/11/14.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Resort.allResorts
    var body: some View {
        NavigationView {
            List(resorts) { resort in
                NavigationLink(
                    destination: Text(resort.name)) {
                    Label(
                        title: {
                            VStack(alignment: .leading) {
                                Text(resort.name)
                                    .font(.headline)
                                Text("\(resort.runs) runs")
                                    .foregroundColor(.secondary)
                            }
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
                        }
                    )
                }
            }
            .navigationBarTitle("Resorts")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
