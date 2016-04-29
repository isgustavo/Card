//
//  Card.swift
//  Card
//
//  Created by Gustavo F Oliveira on 4/27/16.
//  Copyright © 2016 Gustavo F Oliveira. All rights reserved.
//

import UIKit

class Card: UIView {

    @IBOutlet weak var contentView: UIView?
    @IBOutlet weak var mtext: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        self.addSubview(content)
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        self.addSubview(content)
    }
    
    

}
