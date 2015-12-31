//
//  InstructionViewController.swift
//  FinalProject
//
//  Created by Xinyu Zhao on 12/3/15.
//  Copyright © 2015 Molly Zhang. All rights reserved.
//

import UIKit

class InstructionViewController: UIViewController {

    @IBOutlet weak var instructionsLabel: UILabel!
    
    @IBOutlet weak var instruct1: UITextView!
    
    @IBOutlet weak var instruct2: UITextView!
    
    @IBOutlet weak var instruct3: UITextView!
    
    @IBOutlet weak var mainMenu: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = self.view.frame.width
        let half = width/2.0
        instructionsLabel.center = CGPoint(x: half, y: instructionsLabel.center.y)
        instruct1.center = CGPoint(x: half, y: instruct1.center.y)
        instruct2.center = CGPoint(x: half, y: instruct2.center.y)
        instruct3.center = CGPoint(x: half, y: instruct3.center.y)
        mainMenu.center = CGPoint(x: half, y: mainMenu.center.y)
        instruct1.backgroundColor = self.view.backgroundColor
        instruct2.backgroundColor = self.view.backgroundColor
        instruct3.backgroundColor = self.view.backgroundColor

        // Do any additional setup after loading the view.
    }

    @IBAction func mainMenuButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
