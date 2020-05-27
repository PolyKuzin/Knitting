//
//  User.swift
//  knitting
//
//  Created by Павел Кузин on 26.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import Foundation
import Firebase

struct Users {
    
    let uid: String
    let email: String
    
    init (user: User){
        self.uid = user.uid
        self.email = user.email!
    }
}
