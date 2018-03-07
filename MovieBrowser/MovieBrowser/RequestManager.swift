//
//  RequestManager.swift
//  MovieBrowser
//
//  Created by Deepika Dhyani on 07/03/18.
//  Copyright © 2018 Deepika Dhyani. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class RequestManager: NSObject {
    static let sharedManager = RequestManager()
    
    func connectToMovieDBAPI(url: URLConvertible, parameters: NSDictionary?=nil,completion: @escaping (_ responseData: AnyObject? , _ error :AnyObject?, _ status : Bool?)->()) {
        
        Alamofire.request(url, method: .get, parameters: parameters as? Parameters).responseData { (response) in
            if response.result.isSuccess {
                print("result is :",response)
                do{
                    let responseValue:AnyObject? = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject
                    print(responseValue)
                    completion(responseValue, nil, true)
                }
                catch{
                    completion(nil,"err" as AnyObject,false)
                    
                }
            }
            else{
                completion(nil,"err" as AnyObject,false)
                print("fail")
            }
        }
    }
}
