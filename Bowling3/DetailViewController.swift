//
//  DetailViewController.swift
//  Bowling3
//
//  Created by Daichi Yoshikawa on 2020/09/17.
//  Copyright © 2020 Daichi Yoshikawa. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var memoTextView: UITextView!
    var selectedRow: Int!
    var selectedMemo: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TextViewに表示する
        memoTextView.text = selectedMemo
    }
    
    
    @IBAction func deleteMemobutton(_ sender: Any) {
        let ud = UserDefaults.standard
               if ud.array(forKey: "memoArray") != nil{
                   var saveMemoArray = ud.array(forKey: "memoArray") as! [String]
                   saveMemoArray.remove(at: selectedRow)
                   ud.set(saveMemoArray, forKey: "memoArray")
                   ud.synchronize()
                   //画面遷移
                   self.navigationController?.popViewController(animated: true)
                   }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
