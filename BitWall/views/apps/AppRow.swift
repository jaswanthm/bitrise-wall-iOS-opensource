import SwiftUI
import URLImage
struct BitriseAppRow: View {
    @ObservedObject var viewModel: BitriseAppsListViewModel
    @State var app: Datum
    
    let urls = (300..<325).map { "https://picsum.photos/\($0)" }.map { URL(string: $0)! }
    
    
    var body: some View {
        HStack {
 
            URLImage(URL(string: app.avatarURL ?? "https://via.placeholder.com/150")!,
                     delay: 0.25,
                     processors: [ Resize(size: CGSize(width: 50.0, height: 50.0), scale: UIScreen.main.scale) ],
                     content:  {
                        $0.image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
            })
                .frame(width: 50.0, height: 50.0)
                .padding(10)
            
            
            
            Text(app.title)
                .multilineTextAlignment(.leading)
            
            
        }
        .multilineTextAlignment(.center)
        .frame(height: 60)
    }
}
