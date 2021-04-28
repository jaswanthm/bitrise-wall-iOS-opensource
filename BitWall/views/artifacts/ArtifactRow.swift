import SwiftUI

struct ArtifactRow: View {
    @ObservedObject var viewModel: BitriseBuildDetailViewModel
    @State var app: Datum
    @State var build: BitriseBuild
    @State var artifact: Artifact
    @State private var showingAlert = false
    
    
    var body: some View {
        VStack {
            Button(action: {
                self.showingAlert = self.viewModel.getArtifactDetail(appSlug: self.app.slug, buildSlug: self.build.slug, artifactSlug: self.artifact.slug)
            }) {
                Text(self.artifact.title)
            }
            .padding(10)
        }
        .multilineTextAlignment(.center)
        .frame(height: 60)
    }
}
