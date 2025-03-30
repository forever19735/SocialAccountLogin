//
//  AuthenticationError.swift
//  SocialAccountLogin
//
//  Created by 季紅 on 2025/3/27.
//

enum AuthenticationError: Error {
    case cancelled(provider: ThirdPartyAuthenticationType)
    case tokenExpired(provider: ThirdPartyAuthenticationType)
    case unknownError(provider: ThirdPartyAuthenticationType, error: Error?)
    case missingViewController(provider: ThirdPartyAuthenticationType)
    case signInFailed(provider: ThirdPartyAuthenticationType, Error?)
    case missingUserInfo(provider: ThirdPartyAuthenticationType)
}

extension AuthenticationError {
    static func unsupportedProvider(_ type: ThirdPartyAuthenticationType) -> AuthenticationError {
        return .unknownError(provider: type, error: nil)
    }
}
