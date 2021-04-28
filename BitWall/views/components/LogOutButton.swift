//
//  LogoutButton.swift
//  BitWall
//
//  Created by Jaswanth Manigundan on 10/5/20.
//  Copyright © 2020 jaswanth.xyz. All rights reserved.
//

import SwiftUI

struct LogOutButton: View {
    var logOutFunction:() -> Void

    var body: some View {
        Button(action: logOutFunction , label: {
            Text("Log Out")
        })
    }
}
