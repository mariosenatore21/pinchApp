//
//  PageModel.swift
//  pinchApp
//
//  Created by Mario Senatore on 04/01/22.
//

import Foundation


struct Page : Identifiable{
    let id : Int
    let imageName : String
}
extension Page{
    var thumbnailName : String{
        return "thumb-" + imageName
    }
}
