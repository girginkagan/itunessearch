//
//  String+toDate.swift
//  itunessearch
//
//  Created by Kagan Girgin on 4/12/22.
//

import Foundation

extension String {
    func toDate() -> Date{

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.locale = Locale(identifier: "tr_TR")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let date = dateFormatter.date(from:self)
        if date != nil{
            return date!
        }
        else{
            return Date()
        }
    }
    
    func dateFormatter() -> String
    {
        return self.count < 2 ? "0\(self)" : self
    }
}
