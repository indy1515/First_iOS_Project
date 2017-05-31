//
//  Persist.swift
//  MyFirstProject
//
//  Created by Siripong Sae-Zhang on 5/30/2560 BE.
//  Copyright © 2560 IndyZaLab. All rights reserved.
//

import UIKit

public let persist: Persist = Persist() //Global Variable

public class Persist {
    init(){
        
    }
    let saveKey = "SaveList"
    
    func save(news: News) {
        if self.load().contains(where: { $0.id == news.id }) {
            return
        }
        if var saveArray = UserDefaults.standard.array(forKey: saveKey) as? [SaveDictionary] {
            
            saveArray.append(news.asSaveDictionary)
            UserDefaults.standard.set(saveArray, forKey: saveKey)
            
        } else {
            // Save first time -- need to create an storing dictionary
            let newsDictionary = [news.asSaveDictionary]
            UserDefaults.standard.set(newsDictionary, forKey: saveKey)
        }
    }
    
    func load() -> [News] {
        var newsList: [News] = []
        if let savedNewsList = UserDefaults.standard.array(forKey: saveKey) as? [SaveDictionary] {
            for news in savedNewsList {
                newsList.append(News(saveDict:news))
            }
        }
        return newsList
    }
    
    func delete(news: News) {
        if let saveArray = UserDefaults.standard.array(forKey: saveKey) as? [SaveDictionary] {
            let filterArray = saveArray.filter { $0["id"] as? Int != news.asSaveDictionary["id"] as? Int }
            UserDefaults.standard.set(filterArray, forKey: saveKey)
        }
    }
    
    func clear() {
        UserDefaults.standard.set([], forKey: saveKey)
    }
    
    func exist(news: News) -> Bool {
        if let saveArray = UserDefaults.standard.array(forKey: saveKey) as? [SaveDictionary] {
            let filterArray = saveArray.filter { $0["id"] as? Int == news.asSaveDictionary["id"] as? Int }
            return filterArray.count > 0
        }
        return false
    }
}

typealias SaveDictionary = [String: Any]
typealias ABCDictionary = [String: Any]

extension News {
    
    convenience init(saveDict:SaveDictionary){
        let imageRawDataString = saveDict["iconImage"] as? String ?? ""
        let dataDecoded: Data = Data(base64Encoded: imageRawDataString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters) ?? Data()

        self.init(id: saveDict["id"]                      as? Int     ?? -1,
                  title: saveDict["title"]                as? String  ?? "",
                  description: saveDict["description"]    as? String  ?? "",
                  iconImage: UIImage(data: dataDecoded as Data)   ?? UIImage(),
                  author: saveDict["author"]              as? String  ?? "",
                  view: saveDict["view"]                  as? Int     ?? -1,
                  createDate: saveDict["createDate"]      as? String  ?? "",
                  category: saveDict["category"]          as? String  ?? "")
        
    }
    
    var asSaveDictionary: SaveDictionary {
        var newsDictionary: SaveDictionary = [:]
        newsDictionary["id"]            = self.id
        newsDictionary["title"]         = self.title
        newsDictionary["description"]   = self.description
        let imageData:Data = UIImagePNGRepresentation(self.iconImage) ?? Data()
        let strBase64:String = imageData.base64EncodedString(options: .lineLength64Characters)
        newsDictionary["iconImage"]     = strBase64
        newsDictionary["author"]        = self.author
        newsDictionary["view"]          = self.view
        newsDictionary["createDate"]    = self.createDate
        newsDictionary["category"]      = self.category
        return newsDictionary
    }
}


extension Persist {
    
    func alert(title: String, baseView: UIViewController, callback: @escaping ((Bool)->Void) ) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (actionSheetController) -> Void in
            callback(true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (actionSheetController) -> Void in
            callback(false)
        }))
        baseView.present(alert, animated: true, completion: nil)
    }
}
