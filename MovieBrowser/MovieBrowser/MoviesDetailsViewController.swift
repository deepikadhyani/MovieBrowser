//
//  MoviesDetailsViewController.swift
//  MovieBrowser
//
//  Created by Deepika Dhyani on 07/03/18.
//  Copyright © 2018 Deepika Dhyani. All rights reserved.
//

import UIKit

class MoviesDetailsViewController: UIViewController {

    @IBOutlet weak var imgMovieThumbnail: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieReleaseDate: UILabel!
    @IBOutlet weak var lblMovieSynopsis: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    var movieDetailModel:GetMovieResultArrayModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = movieDetailModel?.movieTitle
        setDataOnVC()
        // Do any additional setup after loading the view.
    }
    
    
    func setDataOnVC()  {
        lblMovieTitle.text = movieDetailModel?.movieTitle
        lblMovieSynopsis.text = movieDetailModel?.movieDescription
        lblMovieReleaseDate.text = movieDetailModel?.releaseDate
        if movieDetailModel?.avgRating != nil{
            lblRating.text = String(format: "%.1f", (movieDetailModel?.avgRating)!)
        }
        if movieDetailModel?.poster != nil || movieDetailModel?.poster == ""{
        imgMovieThumbnail.af_setImage(withURL:URL(string: imageBaseURL+(movieDetailModel?.poster)!)!, placeholderImage: UIImage(named: "  "))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
