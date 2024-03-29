//
//  UITextFiew+extension.swift
//  MakeSomeFood
//
//  Created by Луиза Самойленко on 21.05.2023.
//

import UIKit

extension UITextView {

    func addHyperLinksToText(originalText: String, hyperLinks: [String: String]) {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let attributedOriginalText = NSMutableAttributedString(string: originalText)
        for (hyperLink, urlString) in hyperLinks {
            let linkRange = attributedOriginalText.mutableString.range(of: hyperLink)
            let fullRange = NSRange(location: 0, length: attributedOriginalText.length)
            attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString, range: linkRange)
            attributedOriginalText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullRange)
            attributedOriginalText.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Montserrat-Medium", size: 13)!, range: fullRange)
        }

        self.linkTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "green")!,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
        ]
        self.attributedText = attributedOriginalText
    }
}

