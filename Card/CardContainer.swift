//
//  CardContainer.swift
//  Card
//
//  Created by Gustavo F Oliveira on 4/27/16.
//  Copyright © 2016 Gustavo F Oliveira. All rights reserved.
//

import UIKit

protocol CardContainerDataSource: class {
    
    func cardContainerViewNextViewWithIndex(index: Int) -> UIView
    
    func cardContainerViewNumberOfViewInIndex() -> Int
}

class CardContainer: UIView {
    
    private let cardMargin: CGFloat = CGFloat(7.0)
    
    private let viewCount: Int = 3
    private var loadedIndex: Int = 0
    private var currentIndex: Int = 0
    private var defaultFrame: CGRect?
    private var cardCenterX: CGFloat?
    private var cardCenterY: CGFloat?
    
    var dataSource: CardContainerDataSource?
    private var currentViews: [UIView]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("cardViewdrag:"))
        self.addGestureRecognizer(tapGesture)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func reloadCardContainer() {
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        self.currentViews?.removeAll()
        self.currentViews = [UIView]()
        self.loadNextView()
        self.cardViewDefaultScale()
        
    }
    
    func getCurrentView() -> UIView {
        return self.currentViews.first!
    }

    func loadNextView() {
        
        
        if let _ = self.dataSource {
            let index: Int = self.dataSource!.cardContainerViewNumberOfViewInIndex()
        
        
            if index != 0 && index == currentIndex {
                // complete dragging?
            }
        
            if loadedIndex < index {
        
                let preloadViewCont = index <= self.viewCount ? index : self.viewCount
        
                for(var i: Int = currentViews.count; i < preloadViewCont; i += 1) {
            
                    let view = self.dataSource?.cardContainerViewNextViewWithIndex(i)
            
                    if let v = view {
                
                        self.defaultFrame = v.frame
                        self.cardCenterX = v.center.x
                        self.cardCenterY = v.center.y
                        
                        self.addSubview(v)
                        self.sendSubviewToBack(v)
                        currentViews.append(v)
                
                        loadedIndex += 1
                    }
                }
            }
        }
        
        let view = self.getCurrentView()
        
        let tapGesture = UISwipeGestureRecognizer(target: self, action:  #selector(CardContainer.handleCardGesture(_:)))
        tapGesture.direction = UISwipeGestureRecognizerDirection.Down
        
        
        //let tapGesture = UITapGestureRecognizer(target: self, action: Selector("handleCardGesture:"))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    func cardViewDefaultScale() {
        
        var index: Int = 0
        for v in currentViews {
            
            if index == 2 {
                
                v.transform = CGAffineTransformIdentity
                v.frame = CGRectMake(self.defaultFrame!.origin.x, self.defaultFrame!.origin.y - (self.cardMargin * 8) , self.self.defaultFrame!.size.width, self.defaultFrame!.size.height)
                v.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFloat(0.87), CGFloat(0.96))
                
            } else if index == 1 {
                
                v.transform = CGAffineTransformIdentity
                v.frame = CGRectMake(self.defaultFrame!.origin.x, self.defaultFrame!.origin.y - (self.cardMargin * 4) , self.self.defaultFrame!.size.width, self.defaultFrame!.size.height)
                v.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFloat(0.93), CGFloat(0.98))
                
            } else if index == 0 {
                
                v.transform = CGAffineTransformIdentity
                v.frame = self.defaultFrame!
            }
            
            index += 1
            
        }
        print(index)
        
    }
    
    func cardViewdrag(recognizer: UITapGestureRecognizer) {
        //print("card")
        
        
    }
    
    
    func handleCardGesture(recognizer: UITapGestureRecognizer) {
        
        print("card")
        
        let view = self.getCurrentView()
        
        self.currentViews.removeAtIndex(0)
        self.currentIndex += 1
        
        self.loadNextView()
        
        UIView.animateWithDuration(0.35, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations:  {
            
            view.center = CGPointMake(view.center.x, (self.frame.size.height * 1.5));
            self.cardViewDefaultScale()
            
            }, completion: { finished in
            
            }
        )
        
    }


}
