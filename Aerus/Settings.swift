//
//  Settings.swift
//  Aerus
//
//  Created by Joshua Kroslowitz on 2023/9/23.
//

import Foundation

enum SubscriptionLevel: Int {
    case pro = 3
    case basic = 2
    case free = 1
    case trial = 0
}

struct PaymentMethod {
    var cardNum: Int
    var cardHolder: String
    var cvv: Int
    var expiryMonth: Int
    var expiryYear: Int
}

struct accountSettings {
    var workSchedule: WorkPeriod
    var sleepSchedule: SleepPeriod
    var subscription: SubscriptionLevel
    var paymentMethod: PaymentMethod
}

struct systemSettings {
    var twentyFourHrClock: Bool
    var wakeWord: String
    var darkMode: Bool
    var language: String
}

class AppDateFormatter: ObservableObject {
    @Published var formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .short
        f.timeStyle = .short
        return f
    }()
}

enum AppColorMode {
    case dark, light
}

class ColorModeSetting: ObservableObject {
    @Published var currentMode: AppColorMode = .dark
}
