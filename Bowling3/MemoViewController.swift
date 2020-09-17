//
//  MemoViewController.swift
//  Bowling3
//
//  Created by Daichi Yoshikawa on 2020/09/17.
//  Copyright © 2020 Daichi Yoshikawa. All rights reserved.
//

import UIKit

class MemoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var memoArray = [String]()
    
    //ユーザデフォルトをインスタンス化
    let ud = UserDefaults.standard
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addMemoButton(_ sender: Any) {
        self.performSegue(withIdentifier: "goAddMemo", sender: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
           print("do 1")
           return memoArray.count
       }
       
       func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
           print("do 2")
           let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
           cell.textLabel?.text = memoArray[indexPath.row]
           return cell
           
       }
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
           print("do 3")
           self.performSegue(withIdentifier: "goDetail", sender: nil)
           //押したら押した状態を解除
           tableView.deselectRow(at: indexPath, animated: true)
       }
    
    
    override func viewWillAppear(_ animated: Bool){
        loadMemo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("do prepare")
        //destinatiuonのクラッシュを防ぐ
        if segue.identifier == "goDetail"{
            //detailViewControllerを取得
            //as!　DetailViewControllerでダウンキャストししている
            let detailViewController = segue.destination as! DetailViewController
            //遷移前に選ばれているCellが取得できる
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            detailViewController.selectedMemo = memoArray[selectedIndexPath.row]
            detailViewController.selectedRow = selectedIndexPath.row
        }
    }
    
    func loadMemo(){
        print("do loadMemo")
        if ud.array(forKey: "memoArray") != nil{
            //取得 またas!でアンラップしているのでnilじゃない時のみ
            memoArray = ud.array(forKey: "memoArray") as! [String]
            //reloadしてくれる
            tableView.reloadData()
            print("reloadData()")
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        print("do tableView")
        
        if editingStyle == .delete{
            //resultArray内のindexPathのrow番目をremove(消去)する
            memoArray.remove(at: indexPath.row)
            
            //再びアプリ内に消去した配列を保存
            ud.set(memoArray, forKey: "memoArray")
            
            //tableViewを更新
            tableView.reloadData()
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
