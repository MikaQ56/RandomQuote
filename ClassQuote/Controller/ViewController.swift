//
//  ViewController.swift
//  ClassQuote
//
//  Created by Mickael on 01/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowToQuoteLabel()
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var quotelabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var newQuoteButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBAction func tappedNewQuoteButton() {
    }
    
    private func addShadowToQuoteLabel(){
        quotelabel.layer.shadowColor = UIColor.black.cgColor
        quotelabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        quotelabel.layer.shadowOpacity = 0.9
    }
}

