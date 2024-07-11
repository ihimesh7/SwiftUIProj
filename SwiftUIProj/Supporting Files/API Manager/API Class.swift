//
//  API Class.swift
//  Rooted Mint
//
//  Created by Himesh on 11/12/20.
//

import Foundation
import UIKit

var APIInstance = APIManager.sharedInstance

class ServiceKey: NSObject {
    static let baseURL = "https://8ccabr7j0b.execute-api.us-east-2.amazonaws.com/"//https://vbinfotech.website/liveapp/setmarks/api.php?
    static let ImgURL = "http://vbinfotech.website/liveapp/setmarks/images/"
    static let GoogleMapKey = "AIzaSyD3KFdq9ph6MUws87KbmT20XB3a9zoZXtQ"
    static let GoogleURL = "https://maps.googleapis.com/maps/api/"
}

struct APIName {
    static let GetSetting = "settings"
    static let Login = "postUserLogin"
    static let Register = "postUserRegister"
    static let EditProfile = "postUserProfileUpdate"
    static let GetData = "http://universities.hipolabs.com/search?country=United+States"
    static let participant = "participant"
    static let sleep = participant + "/stats/sleep"
}
