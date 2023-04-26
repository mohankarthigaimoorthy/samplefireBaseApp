//
//  ActivityIndicatorLoader.swift
//  demoFireBase
//
//  Created by Mohan K on 11/04/23.
//

import Foundation
import UIKit
import NVActivityIndicatorView

let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

private var activityRestorationIdentifier: String {
    return "NVActivityIndicatorViewContainer"
    
}

public func ShowLoaderWithMessage(message:String) {
    startActivityAnimating(size: CGSize(width:56, height:56), message: message, type: NVActivityIndicatorType.ballRotateChase, color: UIColor.white, padding: 2,isFromOnView: false)
}

public func SHOW_CUSTOM_LOADER() {
    startActivityAnimating(size: CGSize(width:56, height:56), message: nil, type: NVActivityIndicatorType.ballRotateChase, color: UIColor.white, padding: 2,isFromOnView: false)
}


public func HIDE_CUSTOM_LOADER() {
    stopActivityAnimating(isFromOnView: false)
}


public func ShowLoaderOnView() {
    startActivityAnimating(size: CGSize(width:56, height:56), message: nil, type: NVActivityIndicatorType.ballRotateChase, color: .white, padding: 2,isFromOnView: true)
}

public func HideLoaderOnView() {
    stopActivityAnimating(isFromOnView: true)
}

private func startActivityAnimating(size: CGSize? = nil, message: String? = nil, type: NVActivityIndicatorType? = nil, color: UIColor? = nil, padding: CGFloat? = nil, isFromOnView:Bool) {
    DispatchQueue.main.async {
         let activityContainer: UIView = UIView(frame: CGRect(x:0, y:0,width:SCREEN_WIDTH, height:SCREEN_HEIGHT))
           activityContainer.backgroundColor = UIColor.black.withAlphaComponent(0.75)
           activityContainer.restorationIdentifier = activityRestorationIdentifier
           activityContainer.isUserInteractionEnabled = false
           let actualSize = size ?? CGSize(width:56,height:56)
        let activityIndicatorView = NVActivityIndicatorView(
               frame: CGRect(x:0, y:0, width:actualSize.width, height:actualSize.height),
               type: type!,
               color: color!,
               padding: padding!)
           
           activityIndicatorView.center = activityContainer.center
           activityIndicatorView.startAnimating()
           activityContainer.addSubview(activityIndicatorView)
        if message != nil {
            let width = activityContainer.frame.size.width / 2
            if let message = message , !message.isEmpty {
                let label = UILabel(frame: CGRect(x:0, y:0,width:width, height:30))
                label.center = CGPoint(
                    x:activityIndicatorView.center.x, y:
                    activityIndicatorView.center.y + actualSize.height)
                label.textAlignment = .center
                label.text = message
                label.font = UIFont.systemFont(ofSize: 16.0)
                label.textColor = activityIndicatorView.color
                activityContainer.addSubview(label)
            }
        }
        let scene = UIApplication.shared.connectedScenes.first
         if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
             sd.window?.isUserInteractionEnabled = false
             if isFromOnView == true {
                    sd.window?.rootViewController?.view.addSubview(activityContainer)
                }
                else {
                    sd.window?.addSubview(activityContainer)
                }
         }
    }
}

private func stopActivityAnimating(isFromOnView:Bool) {
    
    DispatchQueue.main.async {
        let scene = UIApplication.shared.connectedScenes.first
        guard let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) else {return}
        sd.window?.isUserInteractionEnabled = true
        if isFromOnView == true {
            DispatchQueue.main.async {
                for item in (sd.window?.rootViewController?.view.subviews)!
                    where item.restorationIdentifier == activityRestorationIdentifier {
                        item.removeFromSuperview()
                }
            }
        }else {
            for item in (sd.window?.subviews)!
                where item.restorationIdentifier == activityRestorationIdentifier {
                    item.removeFromSuperview()
            }
        }
    }
}

