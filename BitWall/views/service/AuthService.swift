import Foundation
import KeychainSwift
import Combine

class AuthService : ObservableObject {
    @Published private(set) var bitriseApps = [Datum]()
    @Published var signedIn:Bool = false
    @Published var showErrorAlert:Bool = false

    private var personalToken:String? = nil
    
    init() {
        self.signedIn = AuthService.getPersonalToken() != nil
    }
    
    private var getListCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
//    func splashLogin() -> Void {
//        if(getPersonalToken() != nil) {
//            signIn(personalToken: getPersonalToken()!)
//        }
//    }
        
    // Make sure the API calls once they are finished modify the values on the Main Thread
    func signIn(personalToken : String) {
        let urlComponents = URLComponents(string: "https://api.bitrise.io/v0.1/apps")!
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(personalToken, forHTTPHeaderField: "Authorization")
        
        //OPIb7oJ2IHbWpaxPun3ruRC5EayCP6Onolu_V-Yd_TgVxCh4w9O6hCAAjfxdRyZYsAJn9E8gupdPurenoK71TA
        getListCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap(tryMapApiErrors)
            .decode(type: BitriseAppListResponse.self, decoder: newJSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (completion) in
                switch completion{
                case .failure(let error):
                    self.failureLogin()
                    print(error)
                case .finished:
                    self.successLogin(personalToken: personalToken)
                    break
                }
            }, receiveValue: { (result) in
                self.bitriseApps = result.data
            })
    }
    
    func successLogin(personalToken : String) {
        self.signedIn = true
        self.personalToken = personalToken
        
        let keychain = KeychainSwift()
        //        keychain.accessGroup = "xyz.jaswanth.bitrise"
        keychain.set(personalToken, forKey: "personalToken")
        print(personalToken)
    }
    
    func failureLogin() {
        self.signedIn = false
        self.showErrorAlert = true
        //TODO empty keychain
        //TODO throw error alert
    }
    
    class func getPersonalToken() -> String? {
        let keychain = KeychainSwift()            
        return keychain.get("personalToken")
    }
    
    func signOut(){
        self.signedIn = false
        self.personalToken = nil
        
        let keychain = KeychainSwift()
        keychain.delete("personalToken")
        print(personalToken)
    }
    
    public func tryMapApiErrors(_ output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse else {
            failureLogin()
            throw APIError.badResponse
        }
        // FIXME: Need to confirm this is the only Success Status Code we should expect.
        guard response.statusCode == 200 else {
            failureLogin()
            throw APIError.badData
            //throw APIError.statusCode(error: StatusCodeError(statusCode: response.statusCode, data: output.data))
        }
        guard !output.data.isEmpty else {
            failureLogin()
            throw APIError.badData
        }
        return output.data
    }
}
//
//extension ObservableObject {
//    func getPersonalToken() -> String? {
//        let keychain = KeychainSwift()
//        //        keychain.accessGroup = "xyz.jaswanth.bitrise"
//        if let personalTokenFromKeychain = keychain.get("personalToken") {
//            print(personalTokenFromKeychain)
//            return personalTokenFromKeychain
//        }
//        return nil
//    }
//}
