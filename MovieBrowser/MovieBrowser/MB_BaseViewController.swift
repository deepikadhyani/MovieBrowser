//
//  MB_BaseViewController.swift
//  MovieBrowser
//
//  Created by Deepika Dhyani on 07/03/18.
//  Copyright © 2018 Deepika Dhyani. All rights reserved.
//

import UIKit
import AlamofireImage
class MB_BaseViewController: UIViewController {

    var spinner: MB_Spinner?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func showSpinner() {
        self.hideSpinner()
        spinner = MB_Spinner.init(view: self.view)
        spinner?.showHUD()
    }

    func hideSpinner()  {
        self.spinner?.hideHUD()
        self.spinner = nil
    }
}
