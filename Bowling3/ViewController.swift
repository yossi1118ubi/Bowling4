//
//  ViewController.swift
//  Bowling3
//
//  Created by Daichi Yoshikawa on 2020/09/17.
//  Copyright © 2020 Daichi Yoshikawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func blogButton(_ sender: Any) {
        self.performSegue(withIdentifier: "goBlog", sender: nil)
    }
    
    @IBAction func spreadSheetButton(_ sender: Any) {
        self.performSegue(withIdentifier: "goSpreadSheet", sender: nil)
    }
    
    @IBAction func MemoButton(_ sender: Any) {
        self.performSegue(withIdentifier: "goMemo", sender: nil)
    }
    
    @IBAction func bowlingAlleyButton(_ sender: Any) {
        self.performSegue(withIdentifier: "goBowlingAlley", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

