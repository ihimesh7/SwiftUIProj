//
//  APIManager.swift
//
//  Created by Himesh on 23/07/19.
//  Copyright © 2019 Himesh. All rights reserved.
//

import Foundation
import Alamofire

class APIManager: NSObject {
    // MARK: - Share Instance
    class var sharedInstance: APIManager {
        struct Singleton {
            static let instance = APIManager()
        }
        return Singleton.instance
    }
    // MARK: - Intilize varriable
    enum OptionalError: Error {
        case APIFailureResponse
    }
    //MARK: - API
    func apiService<T: Codable>(_ vc: UIViewController,
                                _ loader: Bool,
                                _ method: HTTPMethod,
                                _ params: [String: Any],
                                _ action: String,
                                _ expecting: T.Type,
                                _ complete: @escaping (Result<T, Error>) -> Void) {
        if loader {
            vc.showIndicator(withTitle: "Loading...")
        }
        if Connectivity.isConnectedToInternet {
            let URL = (ServiceKey.baseURL + action)
            let header : HTTPHeaders = [:]
            AF.request(URL,
                       method: method,
                       parameters: params,
                       encoding: URLEncoding.default,
                       headers: header).responseData { responce in
                let error = responce.error
                let status = responce.response?.statusCode ?? 0
                print(status)
                guard error == nil else { return }
                switch responce.result {
                    case .success(let data):
                        vc.hideIndicator()
                        print("Success")
                        do {
                            let jsonDecode = try self.newJSONDecoder().decode(expecting, from: data)
                            complete(.success(jsonDecode))
                        } catch {
                            complete(.failure(error))
                        }
                    case .failure(let error):
                        vc.hideIndicator()
                        print("Failure")
                        complete(.failure(error))
                }
            }
        } else {
            vc.showAlert(title: AppInfo.AppName, msg: ErrorName.noInternetConnection)
        }
    }
    // MARK: - Upload Profile Pic
    func uploadProfilePic<T: Decodable>(_ vc: UIViewController,
                                        _ loader: Bool,
                                        _ action: String,
                                        _ params: [String:Any],
                                        _ expecting: T.Type,
                                        _ imgparams: [NSObject : AnyObject]?,
                                        _ complete: @escaping (Result<T, Error>) -> Void) {
        if loader {
            vc.showIndicator(withTitle: "Loading...")
        }
        if Connectivity.isConnectedToInternet {
            let base_url = ServiceKey.baseURL + action
            let header : HTTPHeaders = [:]
            AF.upload(multipartFormData: { (multiFormData) in
                if imgparams != nil {
                    for (key, value) in imgparams! {
                        let key = key as? String ?? ""
                        if value is Data {
                            if value as? Data != Data() {
                                multiFormData.append(value as! Data, withName: key, fileName: "\(key).png", mimeType: "image/png")
                            }
                        } else {
                            multiFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                        }
                    }
                    debugPrint(multiFormData.contentType)
                }
            }, to: base_url, usingThreshold: 0, method: .post, headers: header, interceptor: nil, fileManager: .default).responseData { responce in
                let error = responce.error
                let status = responce.response?.statusCode ?? 0
                print(status)
                guard error == nil else { return }
                switch responce.result {
                    case .success(let data):
                        vc.hideIndicator()
                        print("Success")
                        do {
                            let jsonDecode = try self.newJSONDecoder().decode(expecting, from: data)
                            complete(.success(jsonDecode))
                        } catch {
                            complete(.failure(error))
                        }
                    case .failure(let error):
                        vc.hideIndicator()
                        print("Failure")
                        complete(.failure(error))
                }
            }
        } else {
            vc.showAlert(title: AppInfo.AppName, msg: ErrorName.noInternetConnection)
        }
    }
    // MARK: - New JSON
    func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }
    func newJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }
    // MARK: - Convert To Dictionary
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
// MARK: - Check Internet Connectivity
class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
