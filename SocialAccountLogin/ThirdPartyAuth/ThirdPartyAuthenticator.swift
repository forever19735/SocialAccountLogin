//
//  ThirdPartyAuthenticator.swift
//  SocialAccountLogin
//
//  Created by 季紅 on 2025/3/27.
//

import UIKit
protocol ThirdPartyAuthenticationProvider {
    func authenticate(viewController: UIViewController?) async throws -> ThirdPartyAuthModel
}

final class ThirdPartyAuthenticator {
    private let providers: [ThirdPartyAuthenticationType: ThirdPartyAuthenticationProvider]

    init() {
        providers = [
            .facebook: FacebookAuthenticationProvider(),
            .google: GoogleAuthenticationProvider(),
        ]
    }

    func authenticate(with type: ThirdPartyAuthenticationType, viewController: UIViewController?) async throws -> ThirdPartyAuthModel {
        guard let provider = providers[type] else {
            throw AuthenticationError.unsupportedProvider(type)
        }

        return try await provider.authenticate(viewController: viewController)
    }
}

