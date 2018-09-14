//
//  Wallet.swift
//  stellarsdk
//
//  Created by Satraj Bambra on 2018-03-07.
//  Copyright © 2018 Soneso. All rights reserved.
//

import Foundation

/// Generates Mnemonic with corresponding Stellar Keypair.
public final class Wallet {
    
    /// Generates a 12 word Mnemonic. english
    public static func generate12WordMnemonic() -> String {
        return Mnemonic.create(strength: .normal, language: .english)
    }
    
    /// Generates a 24 word Mnemonic. english
    public static func generate24WordMnemonic() -> String {
        return Mnemonic.create(strength: .high, language: .english)
    }
    /// Generates a 12 word Mnemonic. chinese_simplified
    public static func generate12WordMnemonicChineseSimplified() -> String {
        return Mnemonic.create(strength: .normal, language: .chinese_simplified)
    }
    /// Generates a 12 word Mnemonic. chinese_simplified
    public static func generate24WordMnemonicChineseSimplified() -> String {
        return Mnemonic.create(strength: .high, language: .chinese_simplified)
    }
    /// Generates a 12 word Mnemonic. chinese_traditional
    public static func generate12WordMnemonicChineseTraditional() -> String {
        return Mnemonic.create(strength: .normal, language: .chinese_traditional)
    }
    /// Generates a 12 word Mnemonic. chinese_traditional
    public static func generate24WordMnemonicChineseTraditional() -> String {
        return Mnemonic.create(strength: .high, language: .chinese_traditional)
    }
    /// Generates a 12 word Mnemonic. french
    public static func generate12WordMnemonicFrench() -> String {
        return Mnemonic.create(strength: .normal, language: .french)
    }
    /// Generates a 12 word Mnemonic. french
    public static func generate24WordMnemonicFrench() -> String {
        return Mnemonic.create(strength: .high, language: .french)
    }
    /// Generates a 12 word Mnemonic. italian
    public static func generate12WordMnemonicItalian() -> String {
        return Mnemonic.create(strength: .normal, language: .italian)
    }
    /// Generates a 12 word Mnemonic. italian
    public static func generate24WordMnemonicItalian() -> String {
        return Mnemonic.create(strength: .high, language: .italian)
    }
    /// Generates a 12 word Mnemonic. japanese
    public static func generate12WordMnemonicJapanese() -> String {
        return Mnemonic.create(strength: .normal, language: .japanese)
    }
    /// Generates a 12 word Mnemonic. japanese
    public static func generate24WordMnemonicJapanese() -> String {
        return Mnemonic.create(strength: .high, language: .japanese)
    }
    /// Generates a 12 word Mnemonic. korean
    public static func generate12WordMnemonicKorean() -> String {
        return Mnemonic.create(strength: .normal, language: .korean)
    }
    /// Generates a 12 word Mnemonic. korean
    public static func generate24WordMnemonicKorean() -> String {
        return Mnemonic.create(strength: .high, language: .korean)
    }
    /// Generates a 12 word Mnemonic. spanish
    public static func generate12WordMnemonicSpanish() -> String {
        return Mnemonic.create(strength: .normal, language: .spanish)
    }
    /// Generates a 12 word Mnemonic. spanish
    public static func generate24WordMnemonicSpanish() -> String {
        return Mnemonic.create(strength: .high, language: .spanish)
    }
    
    /// Creates a new KeyPair from the given mnemonic and index.
    ///
    /// - Parameter mnemonic: The mnemonic string.
    /// - Parameter passphrase: The passphrase.
    /// - Parameter index: The index of the wallet to generate.
    ///
    public static func createKeyPair(mnemonic: String, passphrase: String?, index: Int) throws -> KeyPair {
        var bip39Seed: Data!
        
        if let passphraseValue = passphrase, !passphraseValue.isEmpty {
            bip39Seed = Mnemonic.createSeed(mnemonic: mnemonic, withPassphrase: passphraseValue)
        } else {
            bip39Seed = Mnemonic.createSeed(mnemonic: mnemonic)
        }
        
        let masterPrivateKey = Ed25519Derivation(seed: bip39Seed)
        let purpose = masterPrivateKey.derived(at: 44)
        let coinType = purpose.derived(at: 148)
        let account = coinType.derived(at: UInt32(index))
        let stellarSeed = try! Seed(bytes: account.raw.bytes)
        let keyPair = KeyPair.init(seed: stellarSeed)
        
        return keyPair
    }
}
