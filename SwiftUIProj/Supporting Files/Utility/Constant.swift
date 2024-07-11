//
//  Constant.swift
//
//  Created by Himesh Mistry on 9/24/21.
//

import Foundation
import UIKit
//import AWSCore

//var APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate
var APP_UTILITES = AppUtilities.sharedInstance
//var CommonAPIInstance = CommonAPI.sharedInstance
let userDefault = UserDefaults.standard
let userKey = UserDefaults.Key.self
let codingFeatsKeyChain = "codingFeats.KeyChain"
var deviceId = UIDevice.current.identifierForVendor?.uuidString ?? "12345666"
let appStoreLink = "itms-apps://apple.com/app/idxxxxx"
let appStoreWebLink = "\nhttps://apps.apple.com/in/app/apple-store/idxxxxx"
let updateLink = "http://itunes.apple.com/us/lookup?bundleId="
let feedbackId = ".com"
let termsLink = "https://hearty-dev-non-sensitive.s3.us-east-2.amazonaws.com/docs/TermsandConditions.html"
let policyLink = "https://hearty-dev-non-sensitive.s3.us-east-2.amazonaws.com/docs/PrivacyPolicy.html"
let sharedSecret = "b38fddf022b546faa340548871f1e3d0"
var newVersion = Int()
var currentVersion = Int()
let updateAvailable = "Update Available v"
var updateMsg = "You are using an older version of this app. Please update with this version"
let updateNow = "Update Now"
let remindMeLater = "Remind me later"
let numbersOnly = "0123456789"
let alphabetsOnly = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
var APIBearerToken = String()

//MARK: - AWS
class AWSConstant: NSObject {
//    static let clientId = "6gok5j00t5jtja3217v1div5pp"//"jvtqmclda9usea308l2b36sb4"
//    static let poolId = "us-east-2_Wh4eSTsAm"//"us-east-1_GCzcmL9B1"
//    static let clientSecret = ""
//    static let region:AWSRegionType = .USEast2
//    static let strRegion = "us-east-2"
//    static var userEmail = String()
//    static var userPwd = String()
//    static let identityPoolID = "us-east-2:f024883e-b7dc-4bfb-98be-cc15da34d261"//"ap-south-1:6949f82d-14f2-4348-8c74-d2f61ee7965a"
//    static let bucketName = "hearty-dev-protected-assets"
//    static let bucketKey = "participants/fc755177-1a42-4531-8673-69115bba9cce/documents/blood/Withings Data Mappings.pdf"
//    static let tokenDS = "token_dataset"
//    static let tokenKey = "token_key"
//    static let get = "get"
//    static let set = "set"
//    static let removeDSObject = "removeDSObject"
//    static let clearDS = "clearDS"
}

class OAuthKey: NSObject {
    static let appClientId = "6gok5j00t5jtja3217v1div5pp"
    static let domain = "hearty-dev.auth.us-east-2.amazoncognito.com"
    static let authURL = "https://hearty-dev.auth.us-east-2.amazoncognito.com/oauth2/authorize"
    static let tokenURL = "https://hearty-dev.auth.us-east-2.amazoncognito.com/oauth2/token"
    static let APIInvocationBaseURL = "https://rpkkz67jsf.execute-api.us-east-2.amazonaws.com"
    static let RedirectUri = "https://localhost:3000"
}

//MARK: - Product
class Product: NSObject {
//    static let tokens100 = "testmb.com.tokens100"
//    static let tokens200 = "testmb.com.tokens200"
//    static let tokens500 = "testmb.com.tokens500"
//    static let setProducts: Set = [tokens100, tokens200, tokens500]//
}

public enum VerifyReceiptURLType: String {
    case production = "https://buy.itunes.apple.com/verifyReceipt"
    case sandbox = "https://sandbox.itunes.apple.com/verifyReceipt"
}

//MARK: - Key
class AdKey: NSObject {
    
}

class KeyChainKey: NSObject {
    static let tokenBalance = "token_balance"
}

//MARK: - Asset
class ColorAsset: NSObject {
    static let accent = UIColor(named: "AccentColor")
    static let gray = UIColor(named: "Gray")
    static let grayLight = UIColor(named: "GrayLight")
    static let skyBlue = UIColor(named: "SkyBlue")
    static let skyBlueLight = UIColor(named: "SkyBlueLight")
    static let green = UIColor(named: "Green")
    static let greenLight = UIColor(named: "GreenLight")
    static let titleColor = UIColor(named: "TitleColor")
    static let subTitleColor_777777 = UIColor(named: "SubTitleColor_777777")
    static let subTitleColor_AAAAAA = UIColor(named: "SubTitleColor_AAAAAA")
    static let subTitleColor_B3B3B3 = UIColor(named: "SubTitleColor_B3B3B3")
    static let gradientPinkDark = UIColor(named: "GradientPinkDark")
    static let gradientPinkLight = UIColor(named: "GradientPinkLight")
    static let gradientBlueDark = UIColor(named: "GradientBlueDark")
    static let gradientBlueLight = UIColor(named: "GradientBlueLight")
    static let gradientBlueLightMedium = UIColor(named: "GradientBlueLightMedium")
    static let borderColor = UIColor(named: "BorderColor")
    static let respirationRateColor = UIColor(hexaRGB: "#ECF9FF")
    static let bodyTemperatureColor = UIColor(named: "BodyTemperatureColor")
    static let bloodGlucoseColor = UIColor(named: "BloodGlucoseColor")
    static let activeTabColor = UIColor(named: "ActiveTabColor")
    static let viewBgColor_F4F7F9 = UIColor(hexaRGB: "#F4F7F9")
    static let blackBtnColor_1F1F1F = UIColor(hexaRGB: "#1F1F1F")
    static let bloodTestBgColor_FAF8F3 = UIColor(hexaRGB: "#FAF8F3")
    static let geneticsBgColor_FAFAFA = UIColor(hexaRGB: "#FAFAFA")
    static let progress1Color_F7E5FF = UIColor(hexaRGB: "#F7E5FF")
    static let progress2Color_D6E1FF = UIColor(hexaRGB: "#D6E1FF")
    static let progress3Color_D8F6FF = UIColor(hexaRGB: "#D8F6FF")
    static let progress4Color_DDF9CE = UIColor(hexaRGB: "#DDF9CE")
    static let greenLightColor_C6F0AE = UIColor(hexaRGB: "#C6F0AE")
    static let orangeLightColor_FDD5B4 = UIColor(hexaRGB: "#FDD5B4")
    static let redLightColor_F4AAAA = UIColor(hexaRGB: "#F4AAAA")
    static let chartGray_FAFAFA = UIColor(named: "ChartGray_FAFAFA")
}

//MARK: - Font
class FontName: NSObject {
    static let poppinsBold = "Poppins-Bold"
    static let poppinsMedium = "Poppins-Medium"
    static let poppinsMediumItalic = "Poppins-MediumItalic"
    static let poppinsRegular = "Poppins-Regular"
    static let poppinsSemiBold = "Poppins-SemiBold"
}

class FontSize: NSObject {
    static let fontRSize = 0.055 * DeviceConstant.screenWidth as CGFloat
}

//MARK: - Date Format
class strDateFormat: NSObject {
    //"yyyy-MM-dd'T'HH:mm:ssZ" //2021-03-09T11:00:00+00:00
    static let old = "yyyy-MM-dd'T'HH:mm:ss"
    static let new = "dd MMM yyyy  hh:mm a"
}

//MARK: - Device
class DeviceConstant: NSObject {
    static let is_iPad = UIUserInterfaceIdiom.pad
    static let is_iPhone = UIUserInterfaceIdiom.phone
    static let screenWidth = (UIScreen.main.bounds.size.width)
    static let screenHeight = (UIScreen.main.bounds.size.height)
    static let window = UIApplication.shared.windows.first!
    static let topPadding = window.safeAreaInsets.top
}

class AppInfo: NSObject {
    static let AppName = Bundle.appName()
    static let AppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? "n/a"
    static let BundleID = Bundle.main.bundleIdentifier
}

//MARK: - Error
class ErrorName: NSObject {
    static let productsUnavailable = "Products are not available at this moment. Stay tuned."
    static let purchaseDisabled = "Purchases are disabled in your devices"
    static let restoreFailed = "Restore Failed"
    static let nothingToRestore = "Nothing to Restore"
    static let restoreSuccess = "Restore Success"
    static let mapAddress = "Select a proper address"
    static let noInternetConnection = "No Internet!!! Please connect Internet."
    static let errorMsg = "Something went wrong. Please check your internet connection"
    static let emptyMobileNo = "Enter a mobile number"
    static let validMobileNo = "Enter a valid mobile number"
    static let emptyEmail = "Enter your email address"
    static let validEmail = "Enter a valid email address"
    static let emptyPwd = "Enter a password"
    static let emptyConfirmPwd = "Enter a confirm password"
    static let shortPwd = "Password should be at least 10 characters long"
    static let notMatchPwd = "Password and confirm password does not match"
    static let incorrectOTP = "Enter correct passcode"
    static let emptyUsername = "Enter a username"
    static let emptyName = "Enter a name"
    static let emptyFName = "Enter first name"
    static let emptyLName = "Enter last name"
    static let emptySubject = "Enter subject"
    static let subjectRange = "Subject character range should not be more than 30"
    static let enoughTokens = "You do not have enough tokens"
    static let emptyDesc = "Enter description"
    static let notAgreed = "Accept agreement and terms"
    static let selectGender = "Select gender"
    static let selectEthnicity = "Select ethnicity"
    static let selectPrimaryGoal = "Select primary goal"
    static let selectProblem = "Select at least one option"
}
// MARK: - View Controller
enum AppStoryboard: String {
    case Main = "Main"
    case Home = "Home"
    case Profile = "Profile"
    case Alert = "Alert"
    case Onboarding = "Onboarding"
    case SignUp = "SignUp"
    case LogIn = "LogIn"
    case Tabbar = "Tabbar"
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
    func initalViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

//MARK: - ImageAsset
class ImageAsset: NSObject {
    static let activeHomeIcon = UIImage(named: "ic_active_home")
}
