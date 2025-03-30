//
//  ThirdPartyAuthenticationType.swift
//  SocialAccountLogin
//
//  Created by 季紅 on 2025/3/27.
//
import UIKit

enum ThirdPartyAuthenticationType: String, CaseIterable {
    case facebook = "facebook"
    case google = "google"

    var icon: UIImage? {
        switch self {
        case .facebook:
            return UIImage(named: "icon_fb_button")
        case .google:
            return UIImage(named: "icon_google_button")
        }
    }
    
    var title: String? {
        switch self {
        case .facebook:
            return "Facebook"
        case .google:
            return "Google"
        }
    }
}
