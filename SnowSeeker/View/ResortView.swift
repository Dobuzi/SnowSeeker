//
//  ResortView.swift
//  SnowSeeker
//
//  Created by 김종원 on 2020/11/15.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @EnvironmentObject var favorites: Favorites
    
    @State private var selectedFacility: Facility?
    
    let resort: Resort
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottomLeading) {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    Label(resort.imageCredit, systemImage: "c.circle")
                        .font(.caption)
                        .padding(5)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(5)
                        .offset(x: 5, y: -5)
                        
                }
                Group {
                    HStack {
                        if sizeClass == .compact {
                            Spacer()
                            VStack { ResortDetailsView(resort: resort) }
                            Spacer()
                            VStack { SkiDetailsView(resort: resort)}
                            Spacer()
                        } else {
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height: 0)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .padding()
            }
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            if self.favorites.contains(self.resort) {
                self.favorites.remove(self.resort)
            } else {
                self.favorites.add(self.resort)
            }
        }, label: {
            Image(systemName: favorites.contains(resort) ? "heart.fill" : "heart")
                .foregroundColor(favorites.contains(resort) ? .red : .gray)
                .font(.title2)
        }))
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var favorites = Favorites()
    static var previews: some View {
        NavigationView {
            ResortView(resort: Resort.example)
                .environmentObject(favorites)
        }
    }
}
