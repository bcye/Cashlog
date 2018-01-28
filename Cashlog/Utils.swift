//
//  CurrencyUtil.swift
//  MoneyTracker
//
//  Created by Bruce Röttgers on 24.01.18.
//  Copyright © 2018 bcye. All rights reserved.
//

import Foundation
import UIKit

//struct for returning the right currency symbol
struct Currency {
    let regionLocale: Locale = Locale.current
    
    //If none symbol is there, return $. Else return current symbol
    func getSymbol() -> String {
        guard let symbol = regionLocale.currencySymbol else { return "$" }
        return symbol
    }
}

extension DateFormatter {
    func stringWithOptions(dateStyle: DateFormatter.Style, date: NSDate, locale: Locale) -> String {
        self.dateStyle = dateStyle
        self.locale = locale
        
        return self.string(from: date as Date)
    }
}

