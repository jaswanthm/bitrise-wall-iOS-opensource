import SwiftUI

struct AppListView: View {
    @ObservedObject var viewModel = BitriseAppsListViewModel()
    
    @EnvironmentObject var authService:AuthService
    
    init() {
        UINavigationBar.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.bitriseApps) { app in
                    NavigationLink(
                        destination: BitriseAppDetail(app: app)
//                        destination: RepositoriesListContainer(viewModel: self.repoViewModel, slug: app.slug)
                    ) {
                        BitriseAppRow(viewModel: self.viewModel, app: app)
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .navigationBarTitle(Text("Bitrise Apps"))
                .navigationBarItems(trailing: LogOutButton(logOutFunction: authService.signOut))
            .onAppear(perform: { self.viewModel.getListV2() })
        }
    }
    
}
