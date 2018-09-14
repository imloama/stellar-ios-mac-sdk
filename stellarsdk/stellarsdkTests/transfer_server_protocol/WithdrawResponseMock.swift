//
//  WithdrawServerMock.swift
//  stellarsdk
//
//  Created by Razvan Chelemen on 08/09/2018.
//  Copyright © 2018 Soneso. All rights reserved.
//

import Foundation

class WithdrawResponseMock: ResponsesMock {
    var address: String
    
    init(address:String) {
        self.address = address
        
        super.init()
    }
    
    override func requestMock() -> RequestMock {
        let handler: MockHandler = { [weak self] mock, request in
            
            if let key = mock.variables["dest"] {
                if key == "GDIODQRBHD32QZWTGOHO2MRZQY2TRG5KTI2NNTFYH2JDYZGMU3NJVAUI" {
                    mock.statusCode = 200
                    return self?.depositSuccess
                } else if key == "GBTMF7Y4S7S3ZMYLIU5MLVEECJETO7FYIZ5OH3GBDD7W3Z4A6556RTMC" {
                    mock.statusCode = 400
                    return nil
                } else if key == "GCIKZJNCDA6W335ODLBIINABY53DJXJTW4PPW6CXK623ZTA6LSYZI7SL" {
                    mock.statusCode = 403
                    return self?.informationNeededNonInteractive
                } else if key == "GDO4YFV4DI5CZ4FOZKD7PLBTAVGFGFIX4ZE4QNJCDLLAA4YOCXHWVVHI" {
                    mock.statusCode = 403
                    return self?.informationNeededInteractive
                } else if key == "GAT3G3YYJJA6PIJJCP33N6RBJODYHMHVA556SBAOZYV5HTGLTFBI2VI3" {
                    mock.statusCode = 403
                    return self?.informationStatus
                } else if key == "GBYLNNAUUJQ7YJSGIATU432IJP2QYTTPKIY5AFWT7LFZAIT76QYVLTAG" {
                    mock.statusCode = 423
                    return self?.error
                }
            }
            
            return self?.depositSuccess
        }
        
        return RequestMock(host: address,
                           path: "/withdraw",
                           httpMethod: "GET",
                           mockHandler: handler)
    }
    
    let depositSuccess = """
    {
        "account_id": "GCIBUCGPOHWMMMFPFTDWBSVHQRT4DIBJ7AD6BZJYDITBK2LCVBYW7HUQ",
        "memo_type": "id",
        "memo": "123"
    }
    """
    
    let informationNeededNonInteractive = """
    {
        "type": "non_interactive_customer_info_needed",
        "fields" : ["family_name", "given_name", "address", "tax_id"]
    }
    """
    
    let informationNeededInteractive = """
    {
        "type": "interactive_customer_info_needed",
        "url" : "https://api.example.com/kycflow?account=GACW7NONV43MZIFHCOKCQJAKSJSISSICFVUJ2C6EZIW5773OU3HD64VI"
    }
    """
    
    let informationStatus = """
    {
      "type": "customer_info_status",
      "status": "denied",
      "more_info_url": "https://api.example.com/kycstatus?account=GACW7NONV43MZIFHCOKCQJAKSJSISSICFVUJ2C6EZIW5773OU3HD64VI"
    }
    """
    
    let error = """
    {
      "error": "This anchor doesn't support the given currency code: ETH"
    }
    """
}
