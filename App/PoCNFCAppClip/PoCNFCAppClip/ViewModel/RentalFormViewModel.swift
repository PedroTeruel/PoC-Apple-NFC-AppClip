//
//  RentalFormViewModel.swift
//  PoCNFCAppClip
//
//  Created by Mariana Fracaroli Lopes on 04/11/26.
//

import SwiftUI
import Observation

@Observable
class RentalFormViewModel {

    var fullName = ""
    var studentCode = ""
    var email = ""
    var phone = ""
    var course = ""

    var isFormValid: Bool {
        !fullName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !studentCode.isEmpty &&
        studentCode.allSatisfy { $0.isNumber } &&
        isValidEmail &&
        !phone.trimmingCharacters(in: .whitespaces).isEmpty &&
        !course.trimmingCharacters(in: .whitespaces).isEmpty
    }

    private var isValidEmail: Bool {
        let emailPattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

        return email.range(
            of: emailPattern,
            options: .regularExpression
        ) != nil
    }
}
