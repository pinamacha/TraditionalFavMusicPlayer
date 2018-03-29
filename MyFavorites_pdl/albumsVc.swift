//
//  albumsVc.swift
//  MyFavorites_pdl
//
//  Created by Ravi Pinamacha on 7/7/17.
//  Copyright © 2017 Ravi Pinamacha. All rights reserved.
//

import UIKit

struct AlbumsData {
    let albumImage:UIImage
    let albumTitleTelugu:String
    let albumTitleEnglish:String
}

class albumsVc: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    
    var albums = [AlbumsData]()
    @objc var selectedAlbum :String?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        albums = [AlbumsData(albumImage: #imageLiteral(resourceName: "lakshmiDevi") ,albumTitleTelugu:"లక్ష్మి",albumTitleEnglish :"Lakshmi Devi"),AlbumsData(albumImage: #imageLiteral(resourceName: "durga"),albumTitleTelugu: "దుర్గామాత",albumTitleEnglish :"Durga Matha"),
            AlbumsData(albumImage: #imageLiteral(resourceName: "saibaba") ,albumTitleTelugu: "సాయిబాబా",albumTitleEnglish :"Saibaba"),
            AlbumsData(albumImage: #imageLiteral(resourceName: "Anjaneya-Swamy"),albumTitleTelugu: "ఆంజనేయస్వామి",albumTitleEnglish :"Anjaneya Swamy"),
            AlbumsData(albumImage: #imageLiteral(resourceName: "venkateswara"),albumTitleTelugu:"వెంకటేశ్వరస్వామి",albumTitleEnglish :"Venkateswara"),
            AlbumsData(albumImage: #imageLiteral(resourceName: "vrathams") ,albumTitleTelugu: "(పూజలు ~ వ్రతాలు)",albumTitleEnglish :"Vrathalu"),
            AlbumsData(albumImage: #imageLiteral(resourceName: "others") ,albumTitleTelugu:"మరికొన్ని" ,albumTitleEnglish :"More")
        ]
                  
                  
                  
        collectionView.dataSource = self
        collectionView.delegate = self
       }
    
    // MARK: UICollectionViewDataSource
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Ccell", for: indexPath) as? CollectionViewCell {
            
            //cell.backgroundColor = .gray
            cell.albumBg.image = albums[indexPath.row].albumImage
            cell.albumNameTelugu.text = albums[indexPath.row].albumTitleTelugu
            cell.albumNameEnglish.text = albums[indexPath.row].albumTitleEnglish
           
            return cell
        }
        return CollectionViewCell()
    }
   
    
    // Through segue send album name t next view controller
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         selectedAlbum = albums[indexPath.row].albumTitleEnglish
        
         performSegue(withIdentifier: "albumToList", sender: selectedAlbum )
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "albumToList" {
            if let destination = segue.destination as? SongListTVc {
                if let selectedalbumPass = sender as? String {
                    destination.albumNameSelected = selectedalbumPass.replacingOccurrences(of: " ", with: "")
                }
            }
        }
    }

    
    
}
