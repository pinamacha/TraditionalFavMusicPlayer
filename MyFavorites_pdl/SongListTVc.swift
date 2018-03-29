//
//  SongListTVc.swift
//  MyFavorites_pdl
//
//  Created by Ravi Pinamacha on 7/8/17.
//  Copyright © 2017 Ravi Pinamacha. All rights reserved.
//

import UIKit

class SongListTVc: UITableViewController {
    
    @objc var albumNameSelected = ""
    @objc var filePath: String?
    @objc var dictArray: [[String: String]] = [] //aray of dictionary

   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("songlist")
        print(albumNameSelected)
        
        //using selected album name get related plist file
        filePath = Bundle.main.path(forResource: albumNameSelected, ofType: "plist")
        dictArray = NSArray(contentsOfFile: filePath!) as! [[String: String]]
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return dictArray.count
     
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SongsCell", for: indexPath) as? TableVCell {
                cell.songNumber.text = "\(indexPath.row + 1)."
                cell.songTitleTelugu.text = dictArray[indexPath.row]["titleTelugu"]
                cell.songTitleEnglish.text = dictArray[indexPath.row]["title"]
                return cell
            }
        
        return UITableViewCell()
    }
    
    //send selected index and albumname previously selected to playsongVc
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "showPlayer", sender: self)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPlayer" {
            let playerVC = segue.destination as! playsongVc
            let indexPath = tableView.indexPathForSelectedRow!
            playerVC.trackId = indexPath.row
            playerVC.albumName = albumNameSelected
            
        }
    }


}
