//
//  StringExtenstions.swift
//  TempoTask
//
//  Created by Hussein Kishk on 20/11/2020.
//

import Foundation

extension String {
    func handleHttpUrlValidation() -> String {
        if self.lowercased().hasPrefix("https://") ||
            self.lowercased().hasPrefix("http://") {
            return self
        } else {
            return "https://" + self
        }
    }
}
