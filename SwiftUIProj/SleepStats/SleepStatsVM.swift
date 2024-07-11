//
//  SleepStatsVM.swift
//  SwiftUIProj
//
//  Created by Himesh on 7/28/22.
//

import Foundation
import Combine

class SleepStatsVM: ObservableObject {
    
    @Published var sleepStats: SleepStats?
    @Published var isAnimating = Bool()
    @Published var presentAlert = Bool()
    @Published var errorMsg = String()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
    }
    
    func combineGetAPI(_ method: RequestMethod, _ token: String) {
        isAnimating = true
        guard let url = URL(string: ServiceKey.baseURL + APIName.sleep) else { return }
//        let data = ["statusTime": DateFormatter().string(from: Date())]
//        let requestBody = try? JSONSerialization.data(withJSONObject: data, options: [])
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
//        request.httpBody = requestBody
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("keep-alive", forHTTPHeaderField: "Connection")
        request.addValue("deflate,gzip", forHTTPHeaderField: "Accept-Encoding")
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode (type: SleepStats.self, decoder: JSONDecoder())
            .sink { [self] completion in
                switch completion {
                    case .failure(let error):
                        print(error)
                        errorMsg = "An error occured: \(error.localizedDescription)"
                        presentAlert = true
                    case .finished:
                        break
                }
                isAnimating = false
            } receiveValue: { [weak self] resultList in
                print("res:")
                print(resultList)
                self?.sleepStats = resultList
                print(self?.sleepStats as Any)
            }
            .store(in: &cancellables)
    }
    
    func handleOutput(_ output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode == 200 else {
            print("response:")
            print(output.response)
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
    
}

//static let connect = HTTPMethod(rawValue: "CONNECT")
//static let delete = HTTPMethod(rawValue: "DELETE")
//static let get = HTTPMethod(rawValue: "GET")
//static let head = HTTPMethod(rawValue: "HEAD")
//static let options = HTTPMethod(rawValue: "OPTIONS")
//static let patch = HTTPMethod(rawValue: "PATCH")
//static let post = HTTPMethod(rawValue: "POST")
//static let put = HTTPMethod(rawValue: "PUT")
//static let trace = HTTPMethod(rawValue: "TRACE")

//struct HTTPMethod {
//    let get: String?
//    let post: String?
//    let put: String?
//    let patch: String?
//    let head: String?
//    let connect: String?
//    let trace: String?
//    let delete: String?
//    let options: String?
//}
struct RequestMethod: RawRepresentable, Equatable, Hashable {
    /// `CONNECT` method.
    public static let connect = RequestMethod(rawValue: "CONNECT")
    /// `DELETE` method.
    public static let delete = RequestMethod(rawValue: "DELETE")
    /// `GET` method.
    public static let get = RequestMethod(rawValue: "GET")
    /// `HEAD` method.
    public static let head = RequestMethod(rawValue: "HEAD")
    /// `OPTIONS` method.
    public static let options = RequestMethod(rawValue: "OPTIONS")
    /// `PATCH` method.
    public static let patch = RequestMethod(rawValue: "PATCH")
    /// `POST` method.
    public static let post = RequestMethod(rawValue: "POST")
    /// `PUT` method.
    public static let put = RequestMethod(rawValue: "PUT")
    /// `TRACE` method.
    public static let trace = RequestMethod(rawValue: "TRACE")
    
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
