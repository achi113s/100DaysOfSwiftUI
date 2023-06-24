//
//  DiceView.swift
//  DiceRolling
//
//  Created by Giorgio Latour on 6/24/23.
//

import SwiftUI

struct DieView: View {
    var dieValue: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.black)
                .frame(width: 100, height: 100)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .frame(width: 85, height: 85)
            
            Text(dieValue)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
    
    init(dieValue: String = "1") {
        self.dieValue = dieValue
    }
}

struct DieView_Previews: PreviewProvider {
    static var previews: some View {
        DieView()
    }
}
