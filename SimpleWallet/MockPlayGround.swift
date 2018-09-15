//
//  MockPlayGround.swift
//  WalletWithAPI
//
//  Created by Akifumi Fujita on 2018/08/15.
//  Copyright © 2018年 Akifumi Fujita. All rights reserved.
//

import Foundation
import BitcoinKit

struct MockPlayGround {
    func verifyScript() -> Bool {
        do {
            let result = try MockHelper.verifySingleKey(lockScript: lockScript, unlockScriptBuilder: unlockScript, key: MockKey.keyB)
            return result
        } catch let error {
            print("Script fail: \(error)")
            return false
        }
    }
    
    let unlockScript = { (pair: SigKeyPair) -> Script in
        let script = try! Script()
            .appendData(pair.sig)
            .appendData(pair.key.pubkey.raw)
        return script
    }

    var lockScript: Script {
        let lockScript = try! Script()
            .append(.OP_DUP)
            .append(.OP_HASH160)
            .appendData(MockKey.keyA.pubkeyHash)
            .append(.OP_EQUALVERIFY)
            .append(.OP_CHECKSIG)
        return lockScript
    }
}
