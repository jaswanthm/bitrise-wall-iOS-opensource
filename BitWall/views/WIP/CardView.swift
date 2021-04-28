//
//  CardView.swift
//  BitWall
//
//  Created by Jaswanth Manigundan on 5/5/20.
//  Copyright © 2020 jaswanth.xyz. All rights reserved.
//

import SwiftUI

struct CardView: View {

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.yellow)

            VStack {
                Text("A")
                    .font(.title)
                    .foregroundColor(.black)
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 400, height: 100)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
