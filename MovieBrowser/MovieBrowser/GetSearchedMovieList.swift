//
//  GetSearchedMovieList.swift
//  MovieBrowser
//
//  Created by Deepika Dhyani on 08/03/18.
//  Copyright © 2018 Deepika Dhyani. All rights reserved.
//

import Foundation
import ObjectMapper

class GetSearchedMovieList: NSObject {
    
    var apiKey : String
    var page : String
    var query : String
    
    init(withApiKey :String, andPage: String, keyword: String) {
        apiKey = withApiKey
        page = andPage
        query = keyword
    }
    
    func getListOfMovie(completion : @escaping(_ response: AnyObject?, _ error: AnyObject?, _ status : Bool)->()) {
        let urlStr =   StringKeyword
        
        RequestManager.sharedManager.connectToMovieDBAPI(url: urlStr, parameters: ["api_key":apiKey, "page": page, "query":query]) { (response, error, status) in
            if error != nil{
                completion(nil,error,false)
            }
            else{
                if response != nil{
                    let responseModel = Mapper<GetMoviesResponseModel>().map(JSON: response as! [String: Any])
                    completion(responseModel as AnyObject?, nil, true)
                }
                else{
                    completion(nil,nil,true)
                }
            }
        }
    }
}
