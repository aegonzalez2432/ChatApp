//
//  MessageModel.swift
//  Messanger
//
//  Created by Consultant on 12/5/22.
//

import Foundation


struct message : Decodable{
    var UID : String
    var body : String
    var timestamp : String
    var username : String
    
}

struct user {
    var UID : String
    var email : String
    var password : String
    var username : String
    
}
