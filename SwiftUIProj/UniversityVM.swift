//
//  UniversityVM.swift
//  SwiftUIProj
//
//  Created by Himesh on 2/13/22.
//

import Foundation
import Alamofire
import Combine

class UniversityVM: ObservableObject {
    
    @Published var universitiesList = [UniversityListElement]()
    @Published var isAnimating = Bool()
    @Published var presentAlert = Bool()
    @Published var errorMsg = String()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
    }
    
    func combineGetAPI(_ method: RequestMethod) {
        isAnimating = true
        guard let url = URL(string: APIName.GetData) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode (type: [UniversityListElement].self, decoder: JSONDecoder())
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
                self?.universitiesList = resultList
                print(self?.universitiesList as Any)
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
    
//    func getAPI(vc: UIViewController, _ method: HTTPMethod, complete: @escaping ([UniversityListElement]?, Error?) -> ()) {
//        APIInstance.apiService(UIViewController(), true, method, [:], APIName.GetData, [UniversityListElement].self) { [self] result in
//            print(result)
//            switch result {
//                case .success(let response):
//                    print("Success")
//                    print(response)
//                    universitiesList = response
//                    complete(response, nil)
//                case .failure(let error):
//                    print("Failure")
//                    print(error)
//                    complete(nil, error)
//            }
//        }
//    }
    
}
