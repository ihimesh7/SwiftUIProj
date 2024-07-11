//
//  Extension.swift
//
//  Created by Himesh Mistry on 9/24/21.
//

import Foundation
import UIKit
//import MBProgressHUD
import StoreKit
import SwiftUI

class MyTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 24, dy: 0)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 24, dy: 0)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 24, dy: 0)
    }
}
//MARK: - Bundle
extension Bundle {
    static func appName() -> String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return ""
        }
        if let version : String = dictionary["CFBundleDisplayName"] as? String {
            return version
        } else {
            return dictionary["CFBundleName"] as? String ?? ""
        }
    }
}
//MARK: - Label
extension UILabel {
    func setHTMLFromString(htmlText: String) {
        let modifiedFont = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(self.font!.pointSize)\">%@</span>", htmlText)
        //process collection values
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        self.attributedText = attrStr
    }
    func calculateMaxLines(width: CGFloat) -> Int {
        let maxSize = CGSize(width: width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font ?? UIFont()], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
    func resolveHashTags() {
        let nsText = NSString(string: self.text ?? "")
        let words = nsText.components(separatedBy: CharacterSet(charactersIn: "@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_").inverted)
        let attrString = NSMutableAttributedString()
        attrString.setAttributedString(self.attributedText ?? NSAttributedString(string: ""))
        for word in words {
            if word.count < 3 {
                continue
            }
            if word.hasPrefix("@") {
                let matchRange:NSRange = nsText.range(of: word as String)
                let stringifiedWord = word.dropFirst()
                if let firstChar = stringifiedWord.unicodeScalars.first, NSCharacterSet.decimalDigits.contains(firstChar) {
                } else {
                    attrString.addAttribute(NSAttributedString.Key.link, value: "hash:\(stringifiedWord)", range: matchRange)
                }
            }
        }
        self.attributedText = attrString
    }
//    func setFont(name: FontName, size: CGFloat) {
//        self.font = UIFont(name: name, size: size)
//    }
}
// MARK: - Button
extension UIButton {
    func setFont(name: String, size: CGFloat) {
        self.titleLabel?.font = UIFont(name: name, size: size)
    }
}
// MARK: - Date
extension Date {
    func convertToLocalTime(fromTimeZone timeZoneAbbreviation: String) -> Date? {
        if let timeZone = TimeZone(abbreviation: timeZoneAbbreviation) {
            let targetOffset = TimeInterval(timeZone.secondsFromGMT(for: self))
            let localOffeset = TimeInterval(TimeZone.autoupdatingCurrent.secondsFromGMT(for: self))
            return self.addingTimeInterval(targetOffset - localOffeset)
        }
        
        return nil
    }
    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
}
// MARK: - UIViewController
extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }
    static func instantAppStoryboard(appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    @IBAction func btnBackClk(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnRootClk(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)
        if let frame = frame {
            child.view.frame = frame
        }
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    func addChild(childController: UIViewController, to view: UIView) {
        self.addChild(childController)
        childController.view.frame = view.bounds
        view.addSubview(childController.view)
        childController.didMove(toParent: self)
    }
    // MARK: - Loader
    func showIndicator(withTitle title: String) {
//        var Indicator = MBProgressHUD()
//        Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
//        Indicator.bezelView.style = .blur
////        Indicator.bezelView.blurEffectStyle = .regular
//        Indicator.bezelView.layer.cornerRadius = 15
//        Indicator.label.text = title
//        Indicator.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
//        Indicator.isUserInteractionEnabled = false
//        Indicator.show(animated: true)
//        self.view.isUserInteractionEnabled = false
    }
    func hideIndicator() {
//        DispatchQueue.main.async {
//            let Indicator = MBProgressHUD()
//            Indicator.backgroundColor = .clear
//            self.view.isUserInteractionEnabled = true
//            MBProgressHUD.hide(for: self.view, animated: true)
//        }
    }
    // MARK: - Share Sheet
    func presentShareSheet(item: Any) {
        let vc = UIActivityViewController(activityItems: [item], applicationActivities: nil)
        vc.popoverPresentationController?.sourceView = self.view
        self.present(vc, animated: true, completion: nil)
    }
    //MARK: - Toast
    func toast(message : String, font: UIFont) {
        let lblToast = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        lblToast.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        lblToast.textColor = UIColor.white
        lblToast.font = font
        lblToast.textAlignment = .center;
        lblToast.text = message
        lblToast.alpha = 1.0
        lblToast.layer.cornerRadius = 10;
        lblToast.clipsToBounds  =  true
        self.view.addSubview(lblToast)
        UIView.animate(withDuration: 2.5, delay: 0.1, options: .curveEaseOut, animations: {
            lblToast.alpha = 0.0
        }, completion: {(isCompleted) in
            lblToast.removeFromSuperview()
        })
    }
    // MARK: - Alert
    func showAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    func showAlertWithCompletion(title: String, msg: String, btnTitle: String, complete: @escaping (Bool) -> ()) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let btnAction = UIAlertAction(title: btnTitle, style: .default) { UIAlertAction in
            complete(true)
        }
        alert.addAction(btnAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    func showAlertWithAction(title: String, msg: String, btnTitle: String, style: UIAlertAction.Style, complete: @escaping (Bool) -> ()) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let btnAction = UIAlertAction(title: btnTitle, style: style) { UIAlertAction in
            complete(true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { UIAlertAction in
            complete(false)
        }
        alert.addAction(btnAction)
        alert.addAction(cancel)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    func showAlertSheet(title: String, msg: String, btnTitle1: String, btnTitle2: String, complete: @escaping (Int) -> ()) {
        let alert = UIAlertController.init(title: title, message: msg, preferredStyle: .actionSheet)
        let btnAction1 = UIAlertAction(title: btnTitle1, style: .default) { UIAlertAction in
            complete(1)
        }
        let btnAction2 = UIAlertAction(title: btnTitle2, style: .default) { UIAlertAction in
            complete(2)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { UIAlertAction in
            complete(0)
        }
        alert.addAction(btnAction1)
        alert.addAction(btnAction2)
        alert.addAction(cancel)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
// MARK: - UIView
extension UIView {
    func setVWShadow(cornerRaduis: CGFloat, shadowRadius: CGFloat, opacity: Float, shadowColor: UIColor, offSet: CGSize) {
        self.layer.cornerRadius = cornerRaduis
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = opacity
    }
    func setGradientColor(_ Color: [UIColor],
                          _ startPT: CGPoint = CGPoint(x: 0.5, y: 0.0),
                          _ endPT: CGPoint = CGPoint(x: 0.5, y: 1.0)) {
        let layer = CAGradientLayer()
        layer.startPoint = startPT
        layer.endPoint = endPT
        layer.frame = self.bounds
        layer.colors = Color.map { $0.cgColor }
        self.layer.addSublayer(layer)
    }
    func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    func setBorder(color: UIColor, width: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    // MARK: - View to pdf
    func viewToPDF(saveToDocumentsWithFileName fileName: String) {
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, self.bounds, nil)
        UIGraphicsBeginPDFPage()
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return }
        self.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
        if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let documentsFileName = documentDirectories + "/" + fileName + "\(Date())" + ".pdf"
            debugPrint(documentsFileName)
            pdfData.write(toFile: documentsFileName, atomically: true)
            //            APP_UTILITES.showAlert(title: "Saved", msg: "Report saved in documents folder.", view: view.viewContainingController ?? UIViewController())
        }
    }
}
// MARK: - String
extension String {
    func toDouble() -> Double {
        let nsString = self as NSString
        return nsString.doubleValue
    }
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    func trim() -> String {
        return self.trimmingCharacters(in : CharacterSet.whitespacesAndNewlines)
    }
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    func parse() -> Int? {
        return Int(self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
    // MARK: - Validation Check
    func isEmptyOrWhitespace() -> Bool {
        if(self.isEmpty) {
            return true
        }
        return (self.trimmingCharacters(in : CharacterSet.whitespaces) == "")
    }
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }
    func validatePhoneNo() -> Bool {
        let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4,10}$"//"^((\\+)|(00))[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
    func validPwd() -> Bool {
        let PWD_REGEX = ".{8,}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PWD_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
    func isNumber() -> Bool {
        let PHONE_REGEX = "^[0-9,+]+"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
    // MARK: - Date
    func covertTimeToLocalZone(formatted: String, formate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatted
        let date = dateFormatter.date(from: self)
        //        let outputTimeZone = TimeZone.current
        //        dateFormatter.timeZone = outputTimeZone
        dateFormatter.dateFormat = formate
        let outputString = dateFormatter.string(from: date ?? Date())
        return outputString
    }
    
}
// MARK: - Int
extension Int {
    // MARK: - Date
    func secondsToHoursMinutes() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        let formattedString = formatter.string(from: TimeInterval(self)) ?? ""
        return formattedString
    }
}

class FlowLayout: UICollectionViewFlowLayout {
    func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        // Copy each item to prevent "UICollectionViewFlowLayout has cached frame mismatch" warning
        guard let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes] else { return nil }
        
        // Constants
        let leftPadding: CGFloat = 8
        let interItemSpacing = minimumInteritemSpacing
        
        // Tracking values
        var leftMargin: CGFloat = leftPadding // Modified to determine origin.x for each item
        var maxY: CGFloat = -1.0 // Modified to determine origin.y for each item
        var rowSizes: [[CGFloat]] = [] // Tracks the starting and ending x-values for the first and last item in the row
        var currentRow: Int = 0 // Tracks the current row
        attributes.forEach { layoutAttribute in
            
            // Each layoutAttribute represents its own item
            if layoutAttribute.frame.origin.y >= maxY {
                
                // This layoutAttribute represents the left-most item in the row
                leftMargin = leftPadding
                
                // Register its origin.x in rowSizes for use later
                if rowSizes.count == 0 {
                    // Add to first row
                    rowSizes = [[leftMargin, 0]]
                } else {
                    // Append a new row
                    rowSizes.append([leftMargin, 0])
                    currentRow += 1
                }
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + interItemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
            
            // Add right-most x value for last item in the row
            rowSizes[currentRow][1] = leftMargin - interItemSpacing
        }
        
        // At this point, all cells are left aligned
        // Reset tracking values and add extra left padding to center align entire row
        leftMargin = leftPadding
        maxY = -1.0
        currentRow = 0
        attributes.forEach { layoutAttribute in
            
            // Each layoutAttribute is its own item
            if layoutAttribute.frame.origin.y >= maxY {
                
                // This layoutAttribute represents the left-most item in the row
                leftMargin = leftPadding
                
                // Need to bump it up by an appended margin
                let rowWidth = rowSizes[currentRow][1] - rowSizes[currentRow][0] // last.x - first.x
                let appendedMargin = (collectionView!.frame.width - leftPadding  - rowWidth - leftPadding) / 2
                leftMargin += appendedMargin
                
                currentRow += 1
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + interItemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        
        return attributes
    }
}
//MARK: - Text View
extension UITextView {
    func resolveHashTags() {
        let nsText = NSString(string: self.text)
        let words = nsText.components(separatedBy: CharacterSet(charactersIn: "@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_").inverted)
        let attrString = NSMutableAttributedString()
        attrString.setAttributedString(self.attributedText)
        for word in words {
            if word.count < 3 {
                continue
            }
            if word.hasPrefix("@") {
                let matchRange:NSRange = nsText.range(of: word as String)
                let stringifiedWord = word.dropFirst()
                if let firstChar = stringifiedWord.unicodeScalars.first, NSCharacterSet.decimalDigits.contains(firstChar) {
                } else {
                    attrString.addAttribute(NSAttributedString.Key.link, value: "hash:\(stringifiedWord)", range: matchRange)
                }
            }
        }
        self.attributedText = attrString
    }
}
//MARK: - Tab Bar
extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        if DeviceConstant.screenHeight >= 812 {
            super.sizeThatFits(size)
            var sizeThatFits = super.sizeThatFits(size)
            sizeThatFits.height = 94
            return sizeThatFits
        }
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 70
        return sizeThatFits
    }
}
//MARK: - CALayer
extension CALayer {
    var setShadow: CALayer {
        self.shadowColor = UIColor.lightGray.cgColor
        self.shadowOpacity = 0.3
        self.shadowOffset = CGSize(width: 0, height: -2)
        self.shadowRadius = 10
        return self
    }
}
//MARK: - CGFloat
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    func fromatSecondsFromTimer() -> String {
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}
//MARK: - CGRect
extension CGRect {
    var lf_originBottom: CGFloat {
        return self.origin.y + self.height
    }
}
//MARK: - UIColor
extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red:   .random(),
            green: .random(),
            blue:  .random(),
            alpha: 1.0
        )
    }
    convenience init?(hexaRGB: String, alpha: CGFloat = 1) {
        var chars = Array(hexaRGB.hasPrefix("#") ? hexaRGB.dropFirst() : hexaRGB[...])
        switch chars.count {
            case 3: chars = chars.flatMap { [$0, $0] }
            case 6: break
            default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                  green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                  blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                  alpha: alpha)
    }
    convenience init?(hexaRGBA: String) {
        var chars = Array(hexaRGBA.hasPrefix("#") ? hexaRGBA.dropFirst() : hexaRGBA[...])
        switch chars.count {
            case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
            case 6: chars.append(contentsOf: ["F","F"])
            case 8: break
            default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                  green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                  blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                  alpha: .init(strtoul(String(chars[6...7]), nil, 16)) / 255)
    }
    convenience init?(hexaARGB: String) {
        var chars = Array(hexaARGB.hasPrefix("#") ? hexaARGB.dropFirst() : hexaARGB[...])
        switch chars.count {
            case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
            case 6: chars.append(contentsOf: ["F","F"])
            case 8: break
            default: return nil
        }
        self.init(red: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                  green: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                  blue: .init(strtoul(String(chars[6...7]), nil, 16)) / 255,
                  alpha: .init(strtoul(String(chars[0...1]), nil, 16)) / 255)
    }
}
//MARK: - Image View
extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
//MARK: - Image
extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size:targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
    convenience init?(withContentsOfUrl imageUrlString: String) throws {
        let imageUrl = URL(string: imageUrlString)!
        let imageData = try Data(contentsOf: imageUrl)
        
        self.init(data: imageData)
    }
}
//MARK: - Table View
extension UITableView {
    func setEmptyMessage(_ message: String,_ color: UIColor) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = color
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: FontSize.fontRSize * 0.8)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
    func scrollToBottom(animated: Bool = true) {
        let section = self.numberOfSections
        if section > 0 {
            let row = self.numberOfRows(inSection: section - 1)
            if row > 0 {
                
                self.scrollToRow(at: IndexPath(row: row-1, section: section-1), at: .bottom, animated: animated)
            }
        }
    }
}
//MARK: - Table View Cell
extension UITableViewCell {
    static func register(_ tableView: UITableView) {
        let cellName = String(describing: self)
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 30
        tableView.tableFooterView = UIView()
    }
}
//MARK: - Collection View
extension UICollectionView {
    func setEmptyMessage(_ message: String,_ color: UIColor) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = color
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: FontSize.fontRSize * 0.8)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
    }
    func restore() {
        self.backgroundView = nil
    }
}
//MARK: - Collectrion View Cell
extension UICollectionViewCell {
    static func register(_ collectionView: UICollectionView)  {
        let cellName = String(describing: self)
        let cellIdentifier = cellName
        let cellNib = UINib(nibName: String(describing: self), bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
    }
}
//MARK: - Text Field
private var __maxLengths = [UITextField: Int]()
extension UITextField {
    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }
    func addPadding(_ padding: PaddingSide) {
        self.leftViewMode = .always
        self.layer.masksToBounds = true
        
        switch padding {
            case .left(let spacing):
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
                self.leftView = paddingView
                self.rightViewMode = .always
            case .right(let spacing):
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
                self.rightView = paddingView
                self.rightViewMode = .always
            case .both(let spacing):
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
                // left
                self.leftView = paddingView
                self.leftViewMode = .always
                // right
                self.rightView = paddingView
                self.rightViewMode = .always
        }
    }
    func clearButton(image: UIImage) {
        clearButtonMode = .never
        rightViewMode   = .whileEditing
        let clearButton = UIButton(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        clearButton.setImage(image, for: .normal)
        clearButton.imageView?.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(clearClicked(sender:)), for: .touchUpInside)
        rightView = clearButton
    }
    @objc func clearClicked(sender:UIButton) {
        text = ""
    }
    func setPlaceholderColor(color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        if let t = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
}
// MARK: - StoreKit
extension SKProduct {
    /// - returns: The cost of the product formatted in the local currency.
    var regularPrice: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        return formatter.string(from: self.price)
    }
    
    var currency: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: self.price)
    }
}
@available(iOS 13.0, *)
extension SKStoreReviewController {
    public static func requestReviewInCurrentScene() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            if #available(iOS 14.0, *) {
                requestReview(in: scene)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
//MARK: - Encodable
extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
//MARK: - Double
extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
//MARK: - Dispatch Queue
extension DispatchQueue {
    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
}
//MARK: - Online Activity
struct OnlineActivity {
    
    var date: Date
    
    func years() -> Int {
        return Calendar.current.dateComponents([.year], from: self.date, to: Date()).year ?? 0
    }
    /// Returns the amount of months from another date
    func months() -> Int {
        return Calendar.current.dateComponents([.month], from: self.date, to: Date()).month ?? 0
    }
    /// Returns the amount of days from another date
    func days() -> Int {
        return Calendar.current.dateComponents([.day], from: self.date, to: Date()).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours() -> Int {
        return Calendar.current.dateComponents([.hour], from: self.date, to: Date()).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes() -> Int {
        return Calendar.current.dateComponents([.minute], from: self.date, to: Date()).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds() -> Int {
        return Calendar.current.dateComponents([.second], from: self.date, to: Date()).second ?? 0
    }
    
    func getOffset() -> String {
        if self.years() > 0 {
            if self.years() == 1 {
                return "\(self.years()) Year ago"
            }
            return "\(self.years()) Years ago"
        } else if months() > 0 {
            if self.months() == 1 {
                return "\(months()) Month ago"
            }
            return "\(months()) Months ago"
        } else if days() > 0 {
            if self.days() == 1 {
                return "\(days()) Day ago"
            }
            return "\(days()) Days ago"
        } else if hours() > 0 {
            if self.hours() == 1 {
                return "\(hours()) Hour ago"
            }
            return "\(hours()) Hours ago"
        } else if minutes() > 0 {
            if self.minutes() == 1 {
                return "\(minutes()) Minute Ago"
            }
            return "\(minutes()) Minutes Ago"
        }
        return ""
    }
}
//MARK: - Notification
extension Notification.Name {
    static let willEnterForeground = Notification.Name("will_enter_foreground")
}

//MARK: - UserDefaults
extension UserDefaults {
    
    enum Key: String, CaseIterable {
        
        case firstLaunch = "first_launch"
        case isSignedIn = "is_signed_in"
        case purchasedProduct = "purchased_product"
        case isPurchased = "is_purchased"
        case isAdRemoved = "isAdRemoved"
        case nextDate = "next_date"
        case remindLater = "remind_later"
        case tokenId = "token_id"
        
    }
    
    func reset() {
        Key.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
    
}

