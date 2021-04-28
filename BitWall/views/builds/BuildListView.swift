//
//  BitriseAppDetail.swift
//  BitWall
//
//  Created by Jaswanth Manigundan on 3/5/20.
//  Copyright © 2020 Jaswanth Manigundan. All rights reserved.
//

import SwiftUI

struct BitriseAppDetail: View {
    @State var app: Datum
    @ObservedObject var viewModel = BitriseAppDetailViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                List(viewModel.bitriseAppBuilds) { build in
                    BuildRow(viewModel: self.viewModel, build: build, bitriseApp: self.app).onAppear {
                        if build == self.viewModel.bitriseAppBuilds.last {
                            if !(self.viewModel.page > 0 && self.viewModel.next == "") {
                                print("I'm inside the last block")
                                self.viewModel.callAgain(appSlug: self.app.slug)
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            
                if self.viewModel.isLoading {
                    loadingIndicator
                }
                
            }
        }
        .navigationBarTitle(Text(app.title))
        .onAppear(perform: { self.viewModel.getBuildsV2(appSlug:self.app.slug) })
    }

    
    private var loadingIndicator: some View {
        Spinner(style: .medium)
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
    }
}
