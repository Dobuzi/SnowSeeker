//
//  Facility.swift
//  SnowSeeker
//
//  Created by 김종원 on 2020/11/15.
//

import SwiftUI

struct Facility: Identifiable {
    let id = UUID()
    var name: String
    
    let keys = [
        "Accommodation",
        "Beginners",
        "Cross-country",
        "Eco-friendly",
        "Family"
    ]
    
    var icon: some View {
        let icons = [
            keys[0]: "house",
            keys[1]: "1.circle",
            keys[2]: "map",
            keys[3]: "leaf.arrow.triangle.circlepath",
            keys[4]: "person.3"
        ]
        
        if let iconName = icons[name] {
            let image = Image(systemName: iconName)
                            .accessibility(label: Text(name))
                            .foregroundColor(.secondary)
            return image
        } else {
            fatalError("Unknown facility type: \(name)")
        }
    }
    
    var alert: Alert {
        let messages = [
            keys[0]: "This resort has popular on-site accommodation.",
            keys[1]: "This resort has lots of ski schools.",
            keys[2]: "This resort has many cross-country ski routes.",
            keys[3]: "This resort has won an award for environmental friendliness.",
            keys[4]: "This resort is popular with families."
        ]
        
        if let message = messages[name] {
            return Alert(title: Text(name), message: Text(message))
        } else {
            fatalError("Unknown facility type: \(name)")
        }
    }
}
