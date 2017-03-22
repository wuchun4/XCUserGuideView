//
//  ViewController.swift
//  XCUserGuide
//
//  Created by Simon on 2017/3/20.
//  Copyright © 2017年 Simon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label1:UILabel?
    @IBOutlet weak var label2:UILabel?
    @IBOutlet weak var button1:UIButton?
    @IBOutlet weak var button2:UIButton?
    
    var guideView:XCUserGuideView?
    var isShow:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !isShow{
            isShow = true
            guideView = XCUserGuideView(frame: self.view.bounds)
            
            self.clickBt(sender:nil)
            
            let bt:UIButton = UIButton(type:.custom)
            bt.frame = CGRect(x: 150, y: 180, width: 100, height: 30)
            bt.setTitle("click next", for: UIControlState.normal)
            bt.addTarget(self, action: #selector(ViewController.next(sender:)), for: .touchUpInside)
            guideView?.addSubview(bt)
            
            
        }
    }
    
    @IBAction func clickBt(sender:UIButton?) {
        
        let item1:XCUserGuideSharpItem = XCUserGuideSharpItem()
        item1.frame = (button1?.frame)!
        item1.title = "Look up FF or ff in Wiktionary, the free dictionary"
        item1.direction = .up
        item1.sharp = .Circle
        item1.guideView = button1
        
        let item2:XCUserGuideSharpItem = XCUserGuideSharpItem()
        item2.frame = (button2?.frame)!
        item2.title = "Like"
        item2.direction = .up
        item2.sharp = .Circle
        item2.guideView = button2
        
        let items1:Array<XCUserGuideSharpItem> = [item1 , item2]
        guideView?.show(rootView: self.view, items: items1 , completion:nil )
    }
    
    
    @IBAction func next(sender:UIButton?) -> Void {
        
        let item1:XCUserGuideSharpItem = XCUserGuideSharpItem()
        item1.frame = (label1?.frame)!
        item1.title = "Ben"
        item1.direction = .up
        item1.sharp = .Circle
        item1.guideView = label1
        
        let item2:XCUserGuideSharpItem = XCUserGuideSharpItem()
        item2.frame = (label2?.frame)!
        item2.title = "Sometimes ever, sometimes never."
        item2.direction = .up
        item2.sharp = .Circle
        item2.guideView = label2
        
        let items1:Array<XCUserGuideSharpItem> = [item1 , item2]
        guideView?.show(rootView: self.view, items: items1 , completion:nil )
    }
    
    @IBAction func showOnce(sender:UIButton){
        
        let tempguide:XCUserGuideView = XCUserGuideView(frame: self.view.bounds)
        
        let item1:XCUserGuideSharpItem = XCUserGuideSharpItem()
        item1.frame = (button1?.frame)!
        item1.title = "Look up FF or ff in Wiktionary, the free dictionary"
        item1.direction = .up
        item1.sharp = .Circle
        item1.guideView = button1
        tempguide.show(rootView: self.view, item: item1, completion: nil)
    }
    
}

