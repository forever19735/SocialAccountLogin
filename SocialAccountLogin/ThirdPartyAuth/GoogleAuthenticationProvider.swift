//
//  GoogleAuthenticationProvider.swift
//  SocialAccountLogin
//
//  Created by 季紅 on 2025/3/27.
//
import GoogleSignIn
import UIKit

struct GoogleAuthenticationProvider: ThirdPartyAuthenticationProvider {
    private let signIn: GIDSignIn

    init(signIn: GIDSignIn = GIDSignIn.sharedInstance) {
        self.signIn = signIn
    }

    func authenticate(viewController: UIViewController?) async throws -> ThirdPartyAuthModel {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async {
                guard let topViewController = viewController else {
                    continuation.resume(throwing: AuthenticationError.missingViewController(provider: .google))
                    return
                }
                signIn.signIn(withPresenting: topViewController) { signInResult, error in
                    if let error = error {
                        continuation.resume(throwing: AuthenticationError.signInFailed(provider: .google, error))
                        return
                    }

                    guard let signInResult = signInResult else {
                        continuation.resume(throwing: AuthenticationError.missingUserInfo(provider: .google))
                        return
                    }

                    let user = signInResult.user
                    let accessToken = user.accessToken.tokenString
                    let model = ThirdPartyAuthModel(
                        type: .google,
                        facebookAccessToken: nil,
                        googleAccessToken: accessToken
                    )
                    continuation.resume(returning: model)
                }
            }
        }
    }
}
