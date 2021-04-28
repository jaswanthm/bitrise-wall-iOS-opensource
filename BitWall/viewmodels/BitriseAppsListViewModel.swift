import SwiftUI
import KeychainSwift
import Combine

final class BitriseAppsListViewModel: ObservableObject {
    @Published private(set) var bitriseApps = [Datum]()
    
    private var getListCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    init() {
        getListV2()
    }
    
    
    deinit {
        getListCancellable?.cancel()
    }
}

extension BitriseAppsListViewModel {
    
    class func getPersonalToken() -> String? {
        let keychain = KeychainSwift()
        return keychain.get("personalToken")
    }
    
    func getListV2() {
        let urlComponents = URLComponents(string: "https://api.bitrise.io/v0.1/apps")!
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(BitriseAppsListViewModel.getPersonalToken()!, forHTTPHeaderField: "Authorization")
        
        //OPIb7oJ2IHbWpaxPun3ruRC5EayCP6Onolu_V-Yd_TgVxCh4w9O6hCAAjfxdRyZYsAJn9E8gupdPurenoK71TA
        getListCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap(tryMapApiErrors)
            .decode(type: BitriseAppListResponse.self, decoder: newJSONDecoder())
            .receive(on: RunLoop.main)
            .print(String(bitriseApps.count))
            .sink(receiveCompletion: { (completion) in
                switch completion{
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            }, receiveValue: { (result) in
                self.bitriseApps = result.data
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
