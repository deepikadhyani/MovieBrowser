//
//  GetMovieListModel.swift
//  MovieBrowser
//
//  Created by Deepika Dhyani on 07/03/18.
//  Copyright © 2018 Deepika Dhyani. All rights reserved.
//

import Foundation
import ObjectMapper

class GetMovieListModel: NSObject {
    
    var apiKey : String
    var page : String
    var category : String
    
    init(withApiKey :String, andPage: String, filter: String) {
        apiKey = withApiKey
        page = andPage
        category = filter
    }
    
    func getListOfMovie(completion : @escaping(_ response: AnyObject?, _ error: AnyObject?, _ status : Bool)->()) {
        let urlStr = BaseURL+category

        RequestManager.sharedManager.connectToMovieDBAPI(url: urlStr, parameters: ["api_key":apiKey, "page": page]) { (response, error, status) in
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

class GetMoviesResponseModel: Mappable {
    var currentPage : Int?
    var totalPage: Int?
    var result: [GetMovieResultArrayModel]?
    var total_results : Int?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        currentPage <- map["page"]
        totalPage <- map["total_pages"]
         result <- map["results"]
       total_results <- map["total_results"]
    }
}

class GetMovieResultArrayModel: Mappable {
    
    var movieTitle: String?
    var poster: String?
    var movieDescription : String?
    var avgRating : Float?
    var releaseDate : String?

    required init?(map: Map) {
        
    }
     func mapping(map: Map) {
        
        movieTitle <- map["title"]
        poster <- map["poster_path"]
        movieDescription <- map["overview"]
        avgRating <- map["vote_average"]
        releaseDate <- map["release_date"]

    }
}
