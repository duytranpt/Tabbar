//
//  String+.swift
//  gif
//
//  Created by Duy Tran on 09/09/2022.
//

import Foundation

extension String {
    func localized(table: String? = nil, bundle: Bundle = .main, args: CVarArg...) -> String {
        return String(format: NSLocalizedString(self, tableName: table, bundle: bundle, value: self, comment: ""), args.first!)
    }
    
    
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    
}
