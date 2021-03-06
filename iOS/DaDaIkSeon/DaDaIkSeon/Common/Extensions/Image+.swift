//
//  Image+.swift
//  DaDaIkSeon
//
//  Created by 양어진 on 2020/12/01.
//

import SwiftUI

extension Image {
    static let mail = Image(systemName: "envelope.fill")
    static let message = Image(systemName: "message.fill")
    static let game = Image(systemName: "gamecontroller.fill")
    static let book = Image(systemName: "book.fill")
    static let creditcard = Image(systemName: "creditcard.fill")
    static let play = Image(systemName: "play.fill")
    static let search = Image(systemName: "magnifyingglass")
    static let thumbsup = Image(systemName: "hand.thumbsup.fill")
    static let calendar = Image(systemName: "calendar.circle")
    static let musicNote = Image(systemName: "music.note")
    static let cart = Image(systemName: "cart.fill")
    static let heart = Image(systemName: "heart.circle.fill")
    static let pin = Image(systemName: "pin.circle.fill")
    static let bolt = Image(systemName: "bolt.fill")
    static let globe = Image(systemName: "globe")
    static let person = Image(systemName: "person.crop.circle")
    static let cancel = Image(systemName: "multiply.circle.fill")
    static let ellipsis = Image(systemName: "ellipsis.circle.fill")
    static let copy = Image(systemName: "doc.on.doc")
    static let plus = Image(systemName: "plus.circle")
    static let chevronRight = Image(systemName: "chevron.right")
    static let chevronDown = Image(systemName: "chevron.down")
    static let back = Image(systemName: "arrow.left.circle.fill")
    static let logo = Image("ddLogo")
    static let delete = Image(systemName: "delete.left.fill")
    static let camera = Image(systemName: "camera.fill")
    static let dadaikseonQR = Image("dadaikseonQR")
    static let check = Image(systemName: "checkmark.circle.fill")
    static let emptyCircle = Image(systemName: "circle")
    static let DDISBackground = Image("background")
}

extension String {
    func toImage() -> Image {
        switch self {
        case "calendar":
            return Image.calendar
        case "creditcard":
            return Image.creditcard
        case "musicNote":
            return Image.musicNote
        case "cart":
            return Image.cart
        case "heart":
            return Image.heart
        case "pin":
            return Image.pin
        case "bolt":
            return Image.bolt
        case "globe":
            return Image.globe
        case "mail":
            return Image.mail
        case "message":
            return Image.message
        case "game":
            return Image.game
        case "book":
            return Image.book
        case "play":
            return Image.play
        case "search":
            return Image.search
        case "thumbsup":
            return Image.thumbsup
        case "delete":
            return Image.delete
        case "cancel":
            return Image.cancel
        default:
            return Image.heart
        }
    }
}
