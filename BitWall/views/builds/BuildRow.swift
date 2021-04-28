import SwiftUI

struct BuildRow: View {
    @ObservedObject var viewModel: BitriseAppDetailViewModel
    @State var build: BitriseBuild
    @State var bitriseApp: Datum
    @State var showingDetail = false
    @State var showingDetailLog = false
    
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        return formatter
    }
    
    var body: some View {
        HStack{
            Rectangle()
                .fill(build.status > 1 ? Color.red : Color.green)
                .frame(width: 5, height: 130)
                .padding(.trailing, 6)
            
            VStack (alignment: .leading) {
                
                HStack {
                    Text("#" + String(build.buildNumber))
                        .font(Font.system(size: 18).bold())
                        .multilineTextAlignment(.leading)
                        .padding(6)
                    
                }
                
                HStack {
                    Image("git")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 18, height: 18, alignment: .leading)
                        .clipShape(Circle())
                    
                    Text(build.branch)
                        .font(.system(size: 14))
                        .padding(6)
                    
                }
                
                HStack {
                    Image("workflow")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 18, height: 18, alignment: .leading)
                        .clipShape(Circle())
                    
                    Text(build.triggeredWorkflow)
                        .font(.system(size: 14))
                        .padding(6)
                    
                }
                
                HStack {
                    Image("clock")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 18, height: 18, alignment: .leading)
                        .clipShape(Circle())
                    
                    Text(dateFormatter.string(from: build.triggeredAt!))
                        .font(.system(size: 14))
                        .padding(6)
                }
                
                HStack {
                    Text("Artifacts")
                        .onTapGesture {
                            self.showingDetail.toggle()
                    }
                    .padding(6)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(6)
                    .sheet(isPresented: $showingDetail) {
                        //                    DetailView(isPresented: self.$showingDetail, bitriseBuild: self.$build, bitriseApp: self.$bitriseApp)
                        ArtifactListView(app: self.bitriseApp, build: self.build, isPresented: self.$showingDetail)
                    }
                    
                    Text("View logs")
                        .onTapGesture {
                            self.showingDetailLog.toggle()
                    }
                    .padding(6)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(6)
                        
                    .sheet(isPresented: $showingDetailLog) {
                        //                    DetailView(isPresented: self.$showingDetail, bitriseBuild: self.$build, bitriseApp: self.$bitriseApp)
                        BuildLogView(app: self.bitriseApp, build: self.build, isPresented: self.$showingDetailLog)
                    }
                    
                    //                    Text("Rebuild")
                    //                    .onTapGesture {
                    //                        self.showingDetail.toggle()
                    //                    }
                    //                    .foregroundColor(Color.blue)
                    //                    .padding(10)
                    //                    .sheet(isPresented: $showingDetail) {
                    //                        //                    DetailView(isPresented: self.$showingDetail, bitriseBuild: self.$build, bitriseApp: self.$bitriseApp)
                    //                        BitriseBuildDetail(app: self.bitriseApp, build: self.build, isPresented: self.$showingDetail)
                    //                    }
                }
            }
        }
    }
}

extension Date {
    
    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
}
struct BitriseBuildRow_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
