import SwiftUI
import KeychainSwift
import Combine

final class BitriseBuildDetailViewModel: ObservableObject {
    @Published private(set) var bitriseLog = ""
    
    @Published private(set) var artifactList = [Artifact]()
    
    @Published private(set) var showAlert = false
    
    @Published private(set) var artifactDetail = DataClass(title: "", artifactType: "", expiringDownloadURL: "", isPublicPageEnabled: false, slug: "", publicInstallPageURL: "", fileSizeBytes: 1)
    
    
    private var getBuildCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    private var getArtifactCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    private var getLogCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    deinit {
        getBuildCancellable?.cancel()
        getArtifactCancellable?.cancel()
        getLogCancellable?.cancel()
        
    }
}

extension BitriseBuildDetailViewModel {
    class func getPersonalToken() -> String? {
        let keychain = KeychainSwift()
        return keychain.get("personalToken")
    }
    
    func getArtifactDetail(appSlug: String, buildSlug : String, artifactSlug: String) -> Bool {
        var urlComponents = URLComponents(string: "https://api.bitrise.io/v0.1/apps/" + appSlug + "/builds/" + buildSlug + "/artifacts/" + artifactSlug)!
        urlComponents.queryItems = [
            URLQueryItem(name: "limit", value: "50")
        ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(BitriseBuildDetailViewModel.getPersonalToken()!, forHTTPHeaderField: "Authorization")
        
        //OPIb7oJ2IHbWpaxPun3ruRC5EayCP6Onolu_V-Yd_TgVxCh4w9O6hCAAjfxdRyZYsAJn9E8gupdPurenoK71TA
        getArtifactCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap(tryMapApiErrors)
            .decode(type: ArtifactDetailResponse.self, decoder: newJSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (completion) in
                switch completion{
                case .failure(let error):
                    print("Error:" + error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { (result) in
                self.artifactDetail = result.data
                
//                if let url = URL(string: self.artifactDetail.expiringDownloadURL) {
//                    UIApplication.shared.open(url)
//                }
//
//                let url = URL(string: self.artifactDetail.expiringDownloadURL)
//                FileDownloader.loadFileAsync(url: url!) { (path, error) in
//                    print("Bitrise File downloaded to : \(path!)")
//
//                }
                
                if let url = URL(string: self.artifactDetail.publicInstallPageURL) {
                    UIApplication.shared.open(url)
                    self.showAlert = false
                } else {
                    self.showAlert = true
                }
            })
        
        return self.showAlert
    }
    
    func getArtifacts(appSlug: String, buildSlug : String) {
        var urlComponents = URLComponents(string: "https://api.bitrise.io/v0.1/apps/" + appSlug + "/builds/" + buildSlug + "/artifacts")!
        urlComponents.queryItems = [
            URLQueryItem(name: "limit", value: "50")
        ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(BitriseBuildDetailViewModel.getPersonalToken()!, forHTTPHeaderField: "Authorization")
        
        //OPIb7oJ2IHbWpaxPun3ruRC5EayCP6Onolu_V-Yd_TgVxCh4w9O6hCAAjfxdRyZYsAJn9E8gupdPurenoK71TA
        getBuildCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap(tryMapApiErrors)
            .decode(type: ArtifactList.self, decoder: newJSONDecoder())
            .receive(on: RunLoop.main)
            .print(String(artifactList.count))
            .sink(receiveCompletion: { (completion) in
                switch completion{
                case .failure(let error):
                    print("Error:" + error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { (result) in
                let list1 = result.data
                let list2 = list1.filter{ ($0.title.contains("ipa") || $0.title.contains("apk")) }
                //TODO show all artifacts or show only ipa and apk ?
                self.artifactList = list1
            })
    }
    
    func getLog(appSlug: String, buildSlug : String) {
        var urlComponents = URLComponents(string: "https://api.bitrise.io/v0.1/apps/" + appSlug + "/builds/" + buildSlug + "/log")!
        
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(BitriseBuildDetailViewModel.getPersonalToken()!, forHTTPHeaderField: "Authorization")
        
        //OPIb7oJ2IHbWpaxPun3ruRC5EayCP6Onolu_V-Yd_TgVxCh4w9O6hCAAjfxdRyZYsAJn9E8gupdPurenoK71TA
        getLogCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap(tryMapApiErrors)
            .decode(type: BitriseBuildLogResponse.self, decoder: newJSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (completion) in
                switch completion{
                case .failure(let error):
                    print("Error:" + error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { (result) in
                let url = result.expiringRawLogURL
                
                let task = URLSession.shared.downloadTask(with: URL(string: url)!) { localURL, urlResponse, error in
                    if let localURL = localURL {
                        if let string = try? String(contentsOf: localURL) {
                            print(string)
                            self.bitriseLog = string
                        }
                    }
                }
                
                task.resume()
            })
    }
    
    public func tryMapApiErrors(_ output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse else {
            throw APIError.badResponse
        }
        // FIXME: Need to confirm this is the only Success Status Code we should expect.
        guard response.statusCode == 200 else {
            throw APIError.badData
            //throw APIError.statusCode(error: StatusCodeError(statusCode: response.statusCode, data: output.data))
        }
        guard !output.data.isEmpty else {
            throw APIError.badData
        }
        return output.data
    }
}
