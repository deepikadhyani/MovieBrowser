//
//  MoviesCollectionViewController.swift
//  MovieBrowser
//
//  Created by Deepika Dhyani on 06/03/18.
//  Copyright © 2018 Deepika Dhyani. All rights reserved.
//

import UIKit
import Alamofire
class MoviesCollectionViewController: MB_BaseViewController,moviesDetailsProtocol, UISearchBarDelegate{
 
    @IBOutlet weak var moviesCollectionView: MoviesCollectionView!
    @IBOutlet weak var movieFilterBtn : UIButton!
    var isPopularSelected = true
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = " "
        moviesCollectionView.movieDelegate = self
        getListOfMovies(page: 1,category: StringPopular)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //Function to get movies data from server
    func getListOfMovies(page:Int, category: String) {
        let requestModel = GetMovieListModel(withApiKey: APIKey ,andPage: "\(page)", filter: category)
        showSpinner()
        requestModel.getListOfMovie {[weak self] (response, err, status) in
            guard  let weakSelf = self else {return}
            weakSelf.hideSpinner()
            if status == true{
                if response != nil{
                    let responseModel = response as! GetMoviesResponseModel
                    let movieResultList = responseModel.result
                    weakSelf.moviesCollectionView.totalPage = responseModel.totalPage!
                    weakSelf.moviesCollectionView.currentPage = responseModel.currentPage!
                    weakSelf.moviesCollectionView.filter = category
                    weakSelf.moviesCollectionView.setDataOnCollection(data: movieResultList!)

                }
            }
            else{
                print("some error occured")
            }
        }
    }
    
    func getListOfSearchedMovies(page: Int, keyword: String) {
        let requestModel = GetSearchedMovieList(withApiKey: APIKey, andPage: "\(page)", keyword: keyword)
        showSpinner()
        requestModel.getListOfMovie {[weak self] (response, err, status) in
            guard  let weakSelf = self else {return}
            weakSelf.hideSpinner()
            if status == true{
                if response != nil{
                    let responseModel = response as! GetMoviesResponseModel
                    let movieResultList = responseModel.result
                    weakSelf.moviesCollectionView.totalPage = responseModel.total_results!
                    weakSelf.moviesCollectionView.currentPage = responseModel.currentPage!
                    weakSelf.moviesCollectionView.filter = StringKeyword
                    weakSelf.moviesCollectionView.setDataOnCollection(data: movieResultList!)
                    
                }
            }
            else{
                print("some error occured")
            }
        }
    }
    
    
    //MARK: moviesDetailsProtocol
    
    func selectedMovie(movieData: GetMovieResultArrayModel) {
        let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: MoviesDetailsViewController.self)) as! MoviesDetailsViewController
        vc.movieDetailModel = movieData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadMoreData(page: Int,filter:String) {
        if filter == StringKeyword{
            getListOfSearchedMovies(page: page, keyword:searchBar.text!)
        }
        else{
            getListOfMovies(page: page,category: filter)
 
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //MARK: UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)

        getListOfSearchedMovies(page: 1, keyword:searchBar.text!)
        //print("abc")
    }
    
    
    
    
    @IBAction func btnMovieFilterClicked(_ sender: Any) {
        
        isPopularSelected == true ? switchFilter(value: 2) : switchFilter(value: 1)
        isPopularSelected = !isPopularSelected
    }
    
    func switchFilter(value: Int)  {
        switch value {
        case 1:
            movieFilterBtn.setTitle("Top Rated", for: .normal)
            getListOfMovies(page: 1,category: StringPopular)
            
        case 2:
            movieFilterBtn.setTitle("Popular", for: .normal)
            getListOfMovies(page: 1,category: StringTopRated)
             
        default:
            print("err")
        }
        
    }
    
}
