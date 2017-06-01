//
//  NewsDetail.swift
//  MyFirstProject
//
//  Created by IndyZa on 6/1/2560 BE.
//  Copyright © 2560 IndyZaLab. All rights reserved.
//

import UIKit
import ObjectMapper

class NewsDetail:Mappable {
    var id: Int = -1
    var imagesUrls: [String] = []
    var content: String = ""
    var lat: Double?
    var lng: Double?
    var link:String = ""
    var createdAt:String = ""
    var updatedAt:String = ""
    private var primaryColorStr: String = "#000000" //Default = Black
    private var secondaryColorStr: String = "#D1D1D1" //Default = Grey
    private var backgroundColorStr: String = "#FFFFFF" //Default = White
    
    var primaryColor:UIColor{
        return UIColor(hexString: self.primaryColorStr)
    }
    
    var secondaryColor:UIColor{
        return UIColor(hexString: self.secondaryColorStr)
    }
    
    var backgroundColor:UIColor{
        return UIColor(hexString: self.backgroundColorStr)
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id                     <- map["id"]
        self.imagesUrls             <- map["images_url"]
        self.link                   <- map["link"]
        self.createdAt              <- map["created_at"]
        self.updatedAt              <- map["updated_at"]
        self.content                <- map["content"]
        self.lat                    <- map["lat"]
        self.lng                    <- map["lng"]
        self.primaryColorStr        <- map["primary_color"]
        self.secondaryColorStr      <- map["secondary_color"]
        self.backgroundColorStr     <- map["background_color"]
    }
    
    
}
