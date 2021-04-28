//
//  LoginView.swift
//  BitWall
//
//  Created by Jaswanth Manigundan on 9/5/20.
//  Copyright © 2020 jaswanth.xyz. All rights reserved.
//

import SwiftUI


struct LoginView: View {
    
    @State var personalToken: String = ""
    
    @EnvironmentObject var authService:AuthService
    
    var body: some View {
        ZStack{
            if(!authService.signedIn){
                VStack {
                    Text("Bitrise Wall")
                        .font(.largeTitle)
                        .padding(40)
                    
                    SecureField("Enter your personal access token", text: $personalToken)
                        .multilineTextAlignment(.center)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(.cyan), lineWidth: 2)
                        )
                        .padding()
                    
                    Button(action: {
                        self.authService.signIn(personalToken: self.personalToken)
                    }) {
                        Text("Login")
                            .padding([.leading,.trailing],30)
                            .padding([.top,.bottom],15)
                    }
                    .disabled(self.personalToken.isEmpty)
                    .foregroundColor(.black)
                    .background(Color(.cyan))
                    .cornerRadius(3)
                    .padding(20)
                    
                    
                    Button("Get your personal access token") {UIApplication.shared.open(URL(string: "https://app.bitrise.io/me/profile#/security")!)}
                        .padding(60)
                        .font(.system(.subheadline))
                        .foregroundColor(.blue)
                }
                .alert(isPresented: $authService.showErrorAlert) {
                           Alert(title: Text("Oops!"), message: Text("Something went wrong!"), dismissButton: .default(Text("Ok")))
                       }
                
            }
            else{
                AppListView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
