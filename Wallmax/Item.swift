//
//  Item.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 18.01.2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
