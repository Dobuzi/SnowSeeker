//
//  ContentView.swift
//  SnowSeeker
//
//  Created by 김종원 on 2020/11/14.
//

import SwiftUI

enum SortingCondition {
    case none
    case alphabetical, country
}

enum FilteringCondition {
    case none
    case country, size, price
}

struct FilterInputView: View {
    @Binding var filteringCondition: FilteringCondition
    @Binding var filterWord: String
    @Binding var filterValue: Int
    
    var size: String {
        switch filterValue {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    var price: String {
        String(repeating: "$", count: filterValue)
    }
    
    var body: some View {
        switch filteringCondition {
        case .country:
            TextField("Country to filter", text: $filterWord)
                .padding()
        case .size:
            Stepper(value: $filterValue, in: 1...3) {
                Text("Size : \(size)")
            }
            .padding()
        case .price:
            Stepper(value: $filterValue, in: 1...3) {
                Text("Price : \(price)")
            }
            .padding()
        default:
            VStack { }
        }
    }
}

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    
    @State private var isSorting = false
    @State private var isFiltering = false
    @State private var showingActionSheet = false
    @State private var sortingCondition: SortingCondition = .none
    @State private var filteringCondition: FilteringCondition = .none
    @State private var filterWord: String = ""
    @State private var filterValue: Int = 1
    
    let resorts: [Resort] = Resort.allResorts
    var body: some View {
        NavigationView {
            VStack {
                FilterInputView(filteringCondition: $filteringCondition,
                                filterWord: $filterWord,
                                filterValue: $filterValue)
                List(resorts.filter(customFilter).sorted {
                    switch sortingCondition {
                    case .country:
                        return $0.country < $1.country
                    case .alphabetical:
                        return $0.id < $1.id
                    default:
                        return true
                    }
                    
                }) { resort in
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
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(leading: Button(action: {
                isSorting.toggle()
                if isSorting {
                    showingActionSheet = true
                } else {
                    sortingCondition = .none
                }
            }) {
                Image(systemName: "arrow.up.arrow.down.circle\(isSorting ? ".fill" : "")")
                    .font(.title2)
            }, trailing: Button(action: {
                isFiltering.toggle()
                if isFiltering {
                    showingActionSheet = true
                } else {
                    filteringCondition = .none
                    filterWord = ""
                    filterValue = 1
                }
            }) {
                Image(systemName: "line.horizontal.3.decrease.circle\(isFiltering ? ".fill" : "")")
                    .font(.title2)
            })
            .actionSheet(isPresented: $showingActionSheet, content: {
                ActionSheet(
                    title: Text(isSorting ? "Sorting Condition" : "Filtering Condition"),
                    message: Text("Choose condition"),
                    buttons: isSorting ? [
                        .default(Text("Country")) {
                            sortingCondition = .country
                        },
                        .default(Text("Resort")) {
                            sortingCondition = .alphabetical
                        },
                        .cancel()
                    ] : [
                        .default(Text("Country")) {
                            withAnimation {
                                filteringCondition = .country
                            }
                        },
                        .default(Text("Size")) {
                            withAnimation {
                                filteringCondition = .size
                            }
                        },
                        .default(Text("Price")) {
                            withAnimation {
                                filteringCondition = .price
                            }
                        },
                        .cancel()
                    ])
            })
            WelcomeView()
        }
        .phoneOnlyStackNavigationViw()
        .environmentObject(favorites)
    }
    
    func customFilter(_ resort: Resort) -> Bool {
        if filterWord != "" || filterValue != 0 {
            switch filteringCondition {
            case .country:
                return resort.country.contains(filterWord)
            case .size:
                return resort.size == filterValue
            case .price:
                return resort.price == filterValue
            default:
                return true
            }
        } else {
            return true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
