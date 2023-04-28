//
//  OrderClass.swift
//  CupcakeCorner
//
//  Created by Giorgio Latour on 4/27/23.
//

import SwiftUI

class OrderClass: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case order
    }
    
    @Published var order = OrderStruct()
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(order, forKey: .order)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        order = try container.decode(OrderStruct.self, forKey: .order)
    }
}
