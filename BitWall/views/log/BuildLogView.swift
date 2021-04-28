//
//  BitriseAppDetail.swift
//  BitWall
//
//  Created by Jaswanth Manigundan on 3/5/20.
//  Copyright © 2020 Jaswanth Manigundan. All rights reserved.
//

import SwiftUI
import WebKit

struct BuildLogView: View {
    @State var app: Datum
    @State var build: BitriseBuild
    @Binding var isPresented : Bool
    @ObservedObject var viewModel = BitriseBuildDetailViewModel()
    
    var body: some View {
        
        NavigationView {
            
            
                if(viewModel.bitriseLog != "") {
                    ScrollView {
                            VStack{
                                Text(viewModel.bitriseLog)
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(20)
                                    .font(Font.system(size:10, design: .monospaced))
                            }.navigationBarTitle(Text(app.title + " " + String(build.buildNumber)), displayMode:.automatic)
                        
                    }
                } else {
                    Text("Loading...")
                }
            
                //                .navigationBarItems(trailing: Button(action: {
                //                    print("Dismissing sheet view...")
                //                    self.isPresented = false
                //                }) {
                //                    Text("Done").bold()
                //                        .font(.subheadline)
                //
                //                })
                
        }.onAppear(perform: { self.viewModel.getLog(appSlug: self.app.slug, buildSlug: self.build.slug) })
    }
}
