//
//  HTTPProtocol.swift
//  CHirag
//
//  Created by Chirag Patel on 21/02/18.
//  Copyright © 2018 chirag. All rights reserved.
//

import UIKit
import Alamofire

extension String {
    /// The Localized string for the receiver
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

enum ErrorCode: Int {
    case noError = 0
    case invalidCredentials = 100
    case userNotVerified = 101
    case userBlocked = 102
    case noDataReceived
    case networkUnavailable
    case unknownError
    
    func localizedDescription() -> String{
        switch self{
        case .noError:
            return "ErrorCode.NoError"
        case .invalidCredentials:
            return "ErrorCode.InvalidCredentials"
        case .userNotVerified:
            return "ErrorCode.UserNotVerified"
        case .userBlocked:
            return "ErrorCode.UserBlocked"
        case .noDataReceived:
            return "ErrorCode.NoDataReceived"
        case .networkUnavailable:
            return "ErrorCode.NetworkUnavailable"
        case .unknownError:
            return "ErrorCode.UnknownError"
        }
    }
}

enum HttpResponseStatusCode: Int {
    case ok = 200
    case badRequest = 400
    case noAuthorization = 401
}

extension NSError{
    convenience init(errorCode: ErrorCode){
        self.init(domain: "LaundyApp", code: errorCode.rawValue, userInfo: [NSLocalizedDescriptionKey : errorCode.localizedDescription()])
    }
}


protocol HTTPProtocol: NSObjectProtocol {

}

extension HTTPProtocol {
    
    func executeWebService(method: HTTPMethod, URLString: String, parameters: [String: AnyObject]?, encoding: Alamofire.ParameterEncoding, headers: [String: String]?, completion: @escaping (_ response:AnyObject?, _ error: NSError?) -> ()){
        print("Fetching WS : \(URLString)")
//        print("With parameters : \(parameters!)")
        if  !NetworkReachabilityManager()!.isReachable {
            completion(nil, NSError(errorCode: ErrorCode.networkUnavailable))
        }
        URLCache.shared.removeAllCachedResponses()
        Alamofire.request(URLString, method: method
            , parameters: parameters, encoding: encoding, headers: headers)
            .responseJSON { (response) in
                if let statusCode = response.response?.statusCode {
                    if  statusCode == HttpResponseStatusCode.noAuthorization.rawValue {
                        completion(nil, NSError(errorCode: ErrorCode.invalidCredentials))
                        return
                    }
                }
                
                if let error = response.result.error {
                    
                    let dataString = String(data: response.data!,encoding: String.Encoding.utf8)
                    //print("Datastring is :- \(dataString)")
                    completion(nil, error as NSError?)
                }
                else {
                    guard let data = response.data
                        else {
                            completion(nil, NSError(errorCode: ErrorCode.noDataReceived))
                            return
                    }
                    
                    do {
                        let unparsedObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject
                        
                        print("response data is :- \(unparsedObject)")
                        
                        if let responseJson: AnyObject = unparsedObject  {
                            completion(responseJson, nil)
                        }
                    }
                    catch let exception as NSError {
                        completion(nil, exception)
                    }
                }
        }
        
    }
    
    func multipartWebService(method: HTTPMethod, URLString: String, parameters: [String: AnyObject]?, fileData: Data?,fileUrl:URL?, headers: [String: String]?, completion: @escaping (_ response:AnyObject?, _ error: NSError?) -> ()){
        if  !NetworkReachabilityManager()!.isReachable {
            completion(nil, NSError(errorCode: ErrorCode.networkUnavailable))
        }
        
//        let manager = Alamofire.Manager.sharedInstance
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let params = parameters, let jsonData = try? JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted){
                multipartFormData.append(jsonData, withName: "data")
//                multipartFormData.appendBodyPart(data:jsonData, name :"data")
            }
            if let data = fileData {
                multipartFormData.append(data, withName: "file", fileName: "file.jpeg", mimeType: "image/jpeg")
//                multipartFormData.appendBodyPart(data:data, name :"file", fileName: "file.jpeg", mimeType: "image/jpeg")
            }
            else if let url = fileUrl
            {
                multipartFormData.append(url, withName: "file")
//                multipartFormData.appendBodyPart(fileURL: url, name: "file")
            }
            
            }, to: URLString, headers: headers) { (encodingResult) in
                switch encodingResult {
                    
                case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                    upload.responseJSON { (response) -> Void in
                        if let statusCode = response.response?.statusCode {
                            if  statusCode == HttpResponseStatusCode.noAuthorization.rawValue {
                                completion(nil, NSError(errorCode: ErrorCode.invalidCredentials))
                                return
                            }
                        }
                        
                        if let error = response.result.error {
                            completion(nil, error as NSError?)
                        }
                        else {
                            guard let data = response.data
                                else {
                                    completion(nil, NSError(errorCode: ErrorCode.noDataReceived))
                                    return
                            }
                            
                            do {
                                let unparsedObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject
                                if let responseJson: AnyObject = unparsedObject  {
                                    completion(responseJson, nil)
                                }
                            }
                            catch let exception as NSError {
                                completion(nil, exception)
                            }
                        }
                    }
                case .failure( _): break
                    
                }
        }
    }
    
    func multipartWebServiceForVideo(method: HTTPMethod, URLString: String, parameters: [String: AnyObject]?, fileData: Data?,fileUrl:URL?, headers: [String: String]?, completion: @escaping (_ response:AnyObject?, _ error: NSError?) -> ()){
    
        if  !NetworkReachabilityManager()!.isReachable {
            completion(nil, NSError(errorCode: ErrorCode.networkUnavailable))
        }

        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let params = parameters, let jsonData = try? JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted){
                multipartFormData.append(jsonData, withName: "data")
            }
            if let url = fileUrl
            {
                multipartFormData.append(url, withName: "file")
            }
            if let data = fileData {
                multipartFormData.append(data, withName: "thumbnail", fileName: "file.jpeg", mimeType: "image/jpeg")
            }
            print(multipartFormData)

            
        }, to: URLString) { (encodingResult) in
            switch encodingResult {
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                    upload.responseJSON { (response) -> Void in
                        if let error = response.result.error {
                            completion(nil, error as NSError?)
                        }
                        else {
                            guard let data = response.data
                                else {
                                    completion(nil, NSError(errorCode: ErrorCode.noDataReceived))
                                    return
                            }
                            
                            do {
                                let unparsedObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject
                                if let responseJson: AnyObject = unparsedObject  {
                                    completion(responseJson, nil)
                                }
                            }
                            catch let exception as NSError {
                                completion(nil, exception)
                            }
                        }
                    }
                case .failure( _): break
                    
                }
        }
        

    }
    
    
}





extension Dictionary{
    func unwrappedValueForKey<PropertyType>(_ key: Key, type: PropertyType.Type, defaultValue: PropertyType) -> PropertyType{
        if let value: PropertyType = self[key] as? PropertyType{
            return value
        }
        
        return defaultValue
    }
}
