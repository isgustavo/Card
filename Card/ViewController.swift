//
//  ViewController.swift
//  Card
//
//  Created by Gustavo F Oliveira on 4/27/16.
//  Copyright © 2016 Gustavo F Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CardContainerDataSource {

    private var container: CardContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        self.view.backgroundColor = UIColor(colorLiteralRed: 235, green: 235, blue: 235, alpha: 1)
        
        self.container = CardContainer()
        self.container.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.container.backgroundColor = UIColor.clearColor()
        self.container.dataSource = self
        
        
        self.view.addSubview(self.container)
        
        //Load values of data bases
        //self.loadData()
        
        self.container.reloadCardContainer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    static var i: Int = 0
    // MARK: - Data Source
    func cardContainerViewNextViewWithIndex(index: Int) -> UIView {
        
        let card: Card = Card(frame: CGRect(x: 15, y: 134, width: self.view.frame.size.width - 30, height: self.view.frame.size.width * 1.3))
        
        if let c = card as? Card {
            c.mtext.text = "\(ViewController.i)"
        }
        
        if ViewController.i == 0 {
            card.contentView?.backgroundColor = UIColor.blackColor()
        } else if ViewController.i == 1 {
            card.contentView?.backgroundColor = UIColor.redColor()
        }else{
            card.contentView?.backgroundColor = UIColor.greenColor()
        }
        
        ViewController.i += 1
        
        return card
        
    }
    
    func cardContainerViewNumberOfViewInIndex() -> Int {
        return 7
    }
}

