//
//  BitriseAppDetail.swift
//  BitWall
//
//  Created by Jaswanth Manigundan on 3/5/20.
//  Copyright © 2020 Jaswanth Manigundan. All rights reserved.
//

import SwiftUI

struct ArtifactListView: View {
    @State var app: Datum
    @State var build: BitriseBuild
    @Binding var isPresented : Bool
    @ObservedObject var viewModel = BitriseBuildDetailViewModel()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                List(viewModel.artifactList) { artifact in
                    ArtifactRow(viewModel: self.viewModel, app: self.app, build: self.build, artifact: artifact)
                }
                .listStyle(GroupedListStyle())
            }
            .navigationBarTitle(Text(app.title + " #" + String(build.buildNumber))).font(.subheadline)
                //                .navigationBarItems(trailing: Button(action: {
                //                    print("Dismissing sheet view...")
                //                    self.isPresented = false
                //                }) {
                //                    Text("Done").bold()
                //                        .font(.subheadline)
                //
                //                })
                .onAppear(perform: { self.viewModel.getArtifacts(appSlug: self.app.slug, buildSlug: self.build.slug) })
        }
        
    }
}
