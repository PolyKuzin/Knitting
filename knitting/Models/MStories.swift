//
//  MStories.swift
//  knitting
//
//  Created by Павел Кузин on 19.06.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import Foundation
import Firebase

struct Story {
    
    let ref				: DatabaseReference?
    var title			: String
    var imageData		: String
    var url				: String
    var text			: String
    
    init( title			: String,
         imageData		: String,
         url			: String,
         text			: String) {

        self.title		= title
        self.imageData	= imageData
        self.url		= url
        self.text		= text
        self.ref		= nil
    }
    
    init( snapshot: DataSnapshot) {
        let snapshotValue	= snapshot.value				as! [String : AnyObject]
        imageData			= snapshotValue["imageData"]	as! String
        title				= snapshotValue["title"]		as! String
        text				= snapshotValue["text"]			as! String
        url					= snapshotValue["url"]			as! String
        ref					= snapshot.ref
    }
    
    func storyToDictionary () -> Any {
        return ["title"				: title,
                "rows"				: text,
                "rowsMax"			: url,
                "congratulations"	: imageData]
    }
}

