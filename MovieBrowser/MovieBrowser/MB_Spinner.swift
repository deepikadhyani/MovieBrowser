//
//  MB_Spinner.swift
//  MovieBrowser
//
//  Created by Deepika Dhyani on 07/03/18.
//  Copyright © 2018 Deepika Dhyani. All rights reserved.
//

import Foundation
import MBProgressHUD

struct MB_Spinner {
    var spinner: MBProgressHUD?
    var spinnerView : UIView?
    init(view: UIView) {
        spinnerView = view
    }
    mutating func showHUD() {
        spinner = MBProgressHUD.showAdded(to: spinnerView!, animated: true)
        spinner?.show(animated: true)
    }
    
    mutating func hideHUD() {
        MBProgressHUD.hide(for: spinnerView!, animated: true)
        self.spinnerView = nil
        self.spinner = nil
    }
}
