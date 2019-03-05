//
//  TomlResponseSignatureMismatchMock.swift
//  stellarsdkTests
//
//  Created by Soneso on 13/11/2018.
//  Copyright © 2018 Soneso. All rights reserved.
//

import Foundation

class TomlResponseSignatureMismatchMock: ResponsesMock {
    var address: String
    
    init(address:String) {
        self.address = address
        
        super.init()
    }
    
    override func requestMock() -> RequestMock {
        
        let handler: MockHandler = { [weak self] mock, request in
            return self?.stellarToml
        }
        
        return RequestMock(host: address,
                           path: "/.well-known/stellar.toml",
                           httpMethod: "GET",
                           mockHandler: handler)
    }
    
    let stellarToml = """
            # Sample stellar.toml
            
            FEDERATION_SERVER="https://api.domain.com/federation"
            AUTH_SERVER="https://api.domain.com/auth"
            TRANSFER_SERVER="https://api.domain.com"
            URI_REQUEST_SIGNING_KEY="GCCHBLJOZUFBVAUZP55N7ZU6ZB5VGEDHSXT23QC6UIVDQNGI6QDQTOOR"
            """
}
