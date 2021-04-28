import SwiftUI
import KeychainSwift
import Combine

final class BitriseAppDetailViewModel: ObservableObject {
    @Published private(set) var bitriseAppBuilds = [BitriseBuild]()
    @Published private(set) var isLoading = false
    @Published private(set) var next = ""
    @Published private(set) var page = 0
    
    
    private var getBuildCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
        
    deinit {
        getBuildCancellable?.cancel()
    }
    
    func callAgain(appSlug: String) {
        print("I'm calling again")
        self.isLoading = true
        getBuildsV2(appSlug: appSlug, next: self.next)
    }
}

extension BitriseAppDetailViewModel {

    func getPersonalToken() -> String? {
          let keychain = KeychainSwift()
          return keychain.get("personalToken")
      }
      
    func getBuildsV2(appSlug : String, next: String = "") {
            var urlComponents = URLComponents(string: "https://api.bitrise.io/v0.1/apps/" + appSlug + "/builds")!
            urlComponents.queryItems = [
                URLQueryItem(name: "limit", value: "5"),
                URLQueryItem(name: "is_on_hold", value: "false")
            ]
        
        if(next != "") {
            urlComponents.queryItems?.append(URLQueryItem(name: "next", value: next))
        }

            var request = URLRequest(url: urlComponents.url!)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(getPersonalToken()!, forHTTPHeaderField: "Authorization")

            //OPIb7oJ2IHbWpaxPun3ruRC5EayCP6Onolu_V-Yd_TgVxCh4w9O6hCAAjfxdRyZYsAJn9E8gupdPurenoK71TA
            getBuildCancellable = URLSession.shared.dataTaskPublisher(for: request)
                .tryMap(tryMapApiErrors)
                .decode(type: BitriseBuildsResponse.self, decoder: newJSONDecoder())
                .receive(on: RunLoop.main)
                .print(String(bitriseAppBuilds.count))
                .sink(receiveCompletion: { (completion) in
                    switch completion{
                    case .failure(let error):
                        print("Error:" + error.localizedDescription)
                        self.isLoading = false
                    case .finished:
                        self.isLoading = false
                        self.page = self.page + 1
                        break
                    }
                }, receiveValue: { (result) in
                    self.bitriseAppBuilds.append(contentsOf: result.data)
                    self.next = result.paging.next ?? ""
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
