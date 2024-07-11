//
//  AppUtilities.swift
//  MAKO Assist
//
//  Created by Himesh Mistry on 9/24/21.
//

import Foundation
import UIKit

class AppUtilities: NSObject {
    // MARK: - Share Instance
    class var sharedInstance: AppUtilities {
        struct Singleton {
            static let instance = AppUtilities()
        }
        return Singleton.instance
    }
    var window: UIWindow?
    // MARK: - List out custom font names
    func listFontNames() {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }
    //MARK: - Archive Ops
    func archImgData(_ img: UIImage, _ key: String) {
        var imgData = Data()
        if #available(iOS 11.0, *) {
            imgData = try! NSKeyedArchiver.archivedData(withRootObject: img, requiringSecureCoding: true)
        } else {
            imgData = NSKeyedArchiver.archivedData(withRootObject: img)
        }
        userDefault.set(imgData, forKey: key)
        userDefault.synchronize()
    }
    func unarchImgData(_ key: String) -> UIImage {
        let imgData = userDefault.data(forKey: key)
        let imgResult = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(imgData ?? Data())
        if imgResult != nil {
            return imgResult as! UIImage
        }
        return UIImage()
    }
    func archData(_ data: Any, _ key: String) {
        var anyData = Data()
        if #available(iOS 11.0, *) {
            anyData = try! NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
        } else {
            anyData = NSKeyedArchiver.archivedData(withRootObject: data)
        }
        userDefault.set(anyData, forKey: key)
        userDefault.synchronize()
    }
    func unarchData(_ key: String) -> Any {
        let anyData = userDefault.data(forKey: key)
        let result = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(anyData ?? Data())
        return result ?? Data()
    }
    //MARK: - Check Update
    func checkUpdate(vc: UIViewController) {
        if !userDefault.bool(forKey: userKey.remindLater.rawValue) {
            _ = try? self.isUpdateAvailable { (update, error) in
                if currentVersion < newVersion {
                    self.showAlertUpdate(title: updateAvailable + "\(newVersion)", msg: updateMsg, view: vc)
                }
                if let error = error {
                    debugPrint(error)
                } else if let update = update {
                    debugPrint(update)
                }
            }
        }
    }
    func isUpdateAvailable(completion: @escaping (Bool?, Error?) -> Void) throws -> URLSessionDataTask {
        guard let info = Bundle.main.infoDictionary,
              let strCurrentVersion = info["CFBundleShortVersionString"] as? String,
              let identifier = info["CFBundleIdentifier"] as? String,
              let url = URL(string: updateLink + identifier) else {
                  throw VersionError.invalidBundleInfo
              }
        currentVersion = Int(strCurrentVersion.replacingOccurrences(of: ".", with: "")) ?? 0
        debugPrint(currentVersion)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let error = error { throw error }
                guard let data = data else { throw VersionError.invalidResponse }
                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
                let jsonResult = json?["results"] as? [Any]
                if !jsonResult!.isEmpty {
                    guard let result = jsonResult?[0] as? [String: Any],
                          let version = result["version"] as? String else {
                              throw VersionError.invalidResponse
                          }
                    debugPrint(version)
                    newVersion = Int(version.replacingOccurrences(of: ".", with: "")) ?? 0
                    completion(version != strCurrentVersion, nil)
                }
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
        return task
    }
    enum VersionError: Error {
        case invalidResponse, invalidBundleInfo
    }
    func nextReminderForUpdate() {
        let nextDate = userDefault.value(forKey: userKey.nextDate.rawValue) as? Date ?? Date()
        if Date() >= nextDate {
            userDefault.setValue(false, forKey: userKey.remindLater.rawValue)
        }
    }
    func showAlertUpdate(title: String, msg: String, view: UIViewController) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let update = UIAlertAction(title: updateNow, style: .default) { UIAlertAction in
            if let url = URL(string: appStoreLink) {
                UIApplication.shared.open(url)
            }
        }
        let later = UIAlertAction(title: remindMeLater, style: .default) { UIAlertAction in
            let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
            debugPrint(nextDate)
            userDefault.setValue(nextDate, forKey: userKey.nextDate.rawValue)
            userDefault.setValue(true, forKey: userKey.remindLater.rawValue)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { UIAlertAction in
        }
        alert.addAction(update)
        alert.addAction(later)
        alert.addAction(cancel)
        DispatchQueue.main.async {
            view.present(alert, animated: true, completion: nil)
        }
    }
    //MARK: - Attributed Button
    func setButtonTitleAttributed(button: UIButton) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.95
        let title = button.title(for: .normal)
        let attributedTitle = NSAttributedString(string: title!, attributes: [
            NSAttributedString.Key.kern: 0.42,
            NSAttributedString.Key.foregroundColor: UIColor(hexaRGB: "#FFFFFF")!,
            NSAttributedString.Key.font: UIFont(name: FontName.poppinsSemiBold, size: 14) as Any,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        button.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    func setAttributedTitle(label: UILabel, _ lightString: String, _ darkString: String) {
        let attributedString = NSMutableAttributedString(string: "")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.89
        
        let lightStringAttribute: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: FontName.poppinsSemiBold, size: 24)!,
            .foregroundColor: ColorAsset.subTitleColor_AAAAAA!,
            .paragraphStyle: paragraphStyle
        ]
        let darkStringAttribute: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: FontName.poppinsSemiBold, size: 24)!,
            .foregroundColor: ColorAsset.titleColor!,
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedLightString = NSAttributedString(string: lightString, attributes: lightStringAttribute)
        let attributedDarkString = NSAttributedString(string: darkString, attributes: darkStringAttribute)
        
        attributedString.append(attributedLightString)
        attributedString.append(attributedDarkString)
        
        label.attributedText = attributedString
    }
    
}
