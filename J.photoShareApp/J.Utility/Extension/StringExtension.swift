//
//  StringExtension.swift
//  J.AskingApp
//
//  Created by JinYoung Lee on 09/11/2018.
//  Copyright © 2018 JinYoung Lee. All rights reserved.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailReg = "^(?:(?:[\\w`~!#$%^&*\\-=+\\;:{}'|,?\\/]+(?:(?:\\.(?:\"(?:\\\\?[\\w`~!#$%^&*\\-=+;:{}'|,?/\\.()<>\\[\\]]|\\\\\"|\\\\)*\"|[\\w`~!#$%^&*\\-=+;:{}'|,?/\\\\]+))*\\.[\\w`~!#$%^&*\\-=+;:{}'|,?/\\\\]+)?)|(?:\"(?:\\\\?[\\w`~!#$%^&*\\-=+;:{}'|,?\\\\ /\\.()<>\\[\\]]|\\\\\"|\\\\)+\"))@(?:[a-zA-Z\\d-]+(?:\\.[a-zA-Z\\d-]+)*|[\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}])$"
        
        return regexTest(regExpression: emailReg)
    }
    
    func isValidPassword() -> Bool {
        let passwordReg = "^(?=.*[a-zA-Z][\\d])[\\w$@$!%*#?&`'\"~^*(){}<>.\\/\\[\\]=+-_|]{6,20}$"
        return regexTest(regExpression: passwordReg)
    }
    
    func isValidNickName() -> Bool {
        let nickNameReg = "^[a-zA-Z0-9\\p{Hangul}]{1,20}$"
        return regexTest(regExpression: nickNameReg)
    }
    
    private func regexTest(regExpression : String) ->Bool{
        let predicate = NSPredicate(format: "SELF MATCHES %@", regExpression)
        return predicate.evaluate(with: self)
    }
    
    func isSpace() -> Bool {
        let count = self.components(separatedBy: NSCharacterSet.whitespaces).count
        return count > 1
    }
}
