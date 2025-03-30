//
//  FacebookAuthenticationProvider.swift
//  SocialAccountLogin
//
//  Created by 季紅 on 2025/3/27.
//
import FacebookLogin

struct FacebookAuthenticationProvider: ThirdPartyAuthenticationProvider {
    private let loginManager: LoginManager

    init(loginManager: LoginManager = LoginManager()) {
        self.loginManager = loginManager
    }

    func authenticate(viewController: UIViewController?) async throws -> ThirdPartyAuthModel {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async {
                self.loginManager.logIn(permissions: ["public_profile"], from: viewController) { result, error in
                    if let error = error {
                        continuation.resume(throwing: AuthenticationError.signInFailed(provider: .facebook, error))
                        return
                    }

                    guard let result = result else {
                        continuation.resume(throwing: AuthenticationError.unknownError(provider: .facebook, error: nil))
                        return
                    }

                    if result.isCancelled {
                        continuation.resume(throwing: AuthenticationError.cancelled(provider: .facebook))
                        return
                    }

                    guard let token = AccessToken.current, !token.isExpired else {
                        continuation.resume(throwing: AuthenticationError.tokenExpired(provider: .facebook))
                        return
                    }
                    let model = ThirdPartyAuthModel(type: .facebook, facebookAccessToken: token.tokenString, googleAccessToken: nil)
                    continuation.resume(returning: model)
                }
            }
        }
    }
}
