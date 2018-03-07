//
//  MoviesCollectionView.swift
//  MovieBrowser
//
//  Created by Deepika Dhyani on 06/03/18.
//  Copyright © 2018 Deepika Dhyani. All rights reserved.
//

import UIKit
import AlamofireImage

protocol moviesDetailsProtocol {
    func selectedMovie(movieData: GetMovieResultArrayModel)
    func loadMoreData(page:Int, filter: String)
}
class MoviesCollectionView: UICollectionView, UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    var movieDelegate: moviesDetailsProtocol!
    var resultArr = [GetMovieResultArrayModel]()
    var totalPage = Int()
    var currentPage = Int()
    var filter = String()
    
    func setDataOnCollection(data:[GetMovieResultArrayModel]) {
        var tempArr = [GetMovieResultArrayModel]()
        tempArr = data
        if currentPage == 1{
            resultArr.removeAll()
        }
        resultArr = resultArr+tempArr
        self.dataSource = self
        self.delegate = self
        self.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:MoviesCollectionViewCell.self), for: indexPath) as! MoviesCollectionViewCell
        let model = resultArr[indexPath.row]
        cell.LblMovieNmae.text = model.movieTitle
        if model.poster != nil || model.poster == ""{
            cell.imgMoviesPoster.af_setImage(withURL: URL(string: imageBaseURL+(model.poster)!)!, placeholderImage: UIImage(named: " "))}
        else{
            cell.imgMoviesPoster.image = UIImage(named: "")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultArr.count
    }
    
    //MARK:UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = resultArr[indexPath.row]
        movieDelegate.selectedMovie(movieData:model)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if resultArr.count != 0 && indexPath.row >= resultArr.count-1  {
            if totalPage > resultArr.count {
                movieDelegate.loadMoreData(page: currentPage+1,filter: filter)
            }
        }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = CGSize(width: (self.bounds.size.width/2)-10, height: (self.bounds.size.height/3)-20)
        return size
    }
}
