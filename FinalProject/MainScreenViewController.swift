//
//  MainScreenViewController.swift
//  FinalProject
//
//  Created by Xinyu Zhao and Molly Zhang on 11/22/15.
//  Copyright © 2015 Xinyu Zhao and Molly Zhang. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabel2: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var instruction: UIButton!
    
    var timer: NSTimer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewWidth = view.frame.width
        titleLabel.center = CGPoint(x: viewWidth/2, y: titleLabel.center.y)
        titleLabel2.center = CGPoint(x: viewWidth/2, y: titleLabel2.center.y)
        playButton.center = CGPoint(x: viewWidth/2, y: playButton.center.y)
        playButton.backgroundColor = UIColor(red:0.50, green:0.50, blue:0.50, alpha:1.0)
        playButton.layer.shadowColor = UIColor(red:0.51, green:0.51, blue:0.51, alpha:1.0).CGColor
        playButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        playButton.layer.shadowOpacity = 0.8
        instruction.center = CGPoint(x: viewWidth/2, y: instruction.center.y)
        
        let explosion = UIImage(named: "explosion")
        self.addImageViews(explosion!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getImage(images: [UIImageView]) -> UIImageView
    {
        let num = Int(arc4random_uniform(UInt32(images.count)))
        return images[num]
    }
    
    func addImageViews(pic: UIImage)
    {
        let width = view.frame.width
        let height = view.frame.height
        let image1 = UIImageView(image: pic)
        let image2 = UIImageView(image: pic)
        let image3 = UIImageView(image: pic)
        let image4 = UIImageView(image: pic)
        image1.frame = CGRect(x: 0, y: 15, width: 30, height: 30)
        image2.frame = CGRect(x: width - 30, y: 15, width: 30, height: 30)
        image3.frame = CGRect(x: 0, y: height - 30, width: 30, height: 30)
        image4.frame = CGRect(x: width - 30, y: height - 30, width: 30, height: 30)
        self.view.addSubview(image1)
        self.view.addSubview(image2)
        self.view.addSubview(image3)
        self.view.addSubview(image4)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
