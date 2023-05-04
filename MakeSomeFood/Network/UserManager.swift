//
//  UserManager.swift
//  MakeSomeFood
//
//  Created by Луиза Самойленко on 03.05.2023.
//

import Foundation
import FirebaseAuth

class UserManager {
    static let shared = UserManager()

    private init(){}

    func changeDisplayName(name: String, _ completion: @escaping () -> Void) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges { _ in
            completion()
            NotificationCenter.default.post(name: .onUserNameChanged, object: nil)
        }
    }
}

extension Notification.Name {
    static let onUserNameChanged = Notification.Name("onUserNameChanged")
}
