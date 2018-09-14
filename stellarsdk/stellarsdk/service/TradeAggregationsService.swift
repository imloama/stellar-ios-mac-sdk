//
//  TradeAggregationsService.swift
//  stellarsdk
//
//  Created by Istvan Elekes on 2/9/18.
//  Copyright © 2018 Soneso. All rights reserved.
//

import Foundation

public class TradeAggregationsService: NSObject {
    let serviceHelper: ServiceHelper
    let jsonDecoder = JSONDecoder()
    
    private override init() {
        serviceHelper = ServiceHelper(baseURL: "")
    }
    
    init(baseURL: String) {
        serviceHelper = ServiceHelper(baseURL: baseURL)
    }
    
    open func getTradeAggregations(startTime:Int64? = nil, endTime:Int64? = nil, resolution:Int64? = nil, baseAssetType:String? = nil, baseAssetCode:String? = nil, baseAssetIssuer:String? = nil, counterAssetType:String? = nil, counterAssetCode:String? = nil, counterAssetIssuer:String? = nil, order:Order? = nil, limit:Int? = nil, response:@escaping (_ response: [Any]) -> Void, failure: @escaping () -> Void) {
        
        var requestPath = "/trade_aggregations"
        var params = Dictionary<String,String>()
        if let start = startTime { params["start_time"] = String(start) }
        if let end = endTime { params["end_time"] = String(end) }
        if let res = resolution { params["resolution"] = String(res) }
        params["base_asset_type"] = baseAssetType
        params["base_asset_code"] = baseAssetCode
        params["base_asset_issuer"] = baseAssetIssuer
        params["counter_asset_type"] = counterAssetType
        params["counter_asset_code"] = counterAssetCode
        params["counter_asset_issuer"] = counterAssetIssuer
        params["order"] = order?.rawValue
        if let limit = limit { params["limit"] = String(limit) }
        
        if let pathParams = params.stringFromHttpParameters(),
            pathParams.count > 0 {
            requestPath += "?\(pathParams)"
        }
        
        getTradeAggregationsFromUrl(url:serviceHelper.baseURL + requestPath, response:response, failure:failure)
    }
    
    open func getTradeAggregationsFromUrl(url:String, response:@escaping (_ response: [Any]) -> Void, failure: @escaping () -> Void) {
        serviceHelper.GETRequestFromUrl(url: url) { (result) -> (Void) in
            switch result {
            case .success(let data):
                do {
                    //解析数据
                    let dic = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                    print("\(dic)")
                    
                    //取出_embedded数据
                    let dict = dic["_embedded"] as! [String: Any]
                    //取出kline数据
                    let kArr = dict["records"] as! [[String: Any]]
                    response(kArr)
                } catch {
                    failure()
//                    response(.failure(error: .parsingResponseFailed(message: error.localizedDescription)))
                }
            case .failure(let error):
//                response(.failure(error:error))
                failure()
                print("\(error)")
            }
        }
    }
    
//    open func getTradeAggregations(startTime:Int64? = nil, endTime:Int64? = nil, resolution:Int64? = nil, baseAssetType:String? = nil, baseAssetCode:String? = nil, baseAssetIssuer:String? = nil, counterAssetType:String? = nil, counterAssetCode:String? = nil, counterAssetIssuer:String? = nil, order:Order? = nil, limit:Int? = nil, response:@escaping PageResponse<TradeAggregationResponse>.ResponseClosure) {
//
//        var requestPath = "/trade_aggregations"
//        var params = Dictionary<String,String>()
//        if let start = startTime { params["start_time"] = String(start) }
//        if let end = endTime { params["end_time"] = String(end) }
//        if let res = resolution { params["resolution"] = String(res) }
//        params["base_asset_type"] = baseAssetType
//        params["base_asset_code"] = baseAssetCode
//        params["base_asset_issuer"] = baseAssetIssuer
//        params["counter_asset_type"] = counterAssetType
//        params["counter_asset_code"] = counterAssetCode
//        params["counter_asset_issuer"] = counterAssetIssuer
//        params["order"] = order?.rawValue
//        if let limit = limit { params["limit"] = String(limit) }
//
//        if let pathParams = params.stringFromHttpParameters(),
//            pathParams.count > 0 {
//            requestPath += "?\(pathParams)"
//        }
//
//        getTradeAggregationsFromUrl(url:serviceHelper.baseURL + requestPath, response:response)
//    }
//
//    open func getTradeAggregationsFromUrl(url:String, response:@escaping PageResponse<TradeAggregationResponse>.ResponseClosure) {
//        serviceHelper.GETRequestFromUrl(url: url) { (result) -> (Void) in
//            switch result {
//            case .success(let data):
//                do {
////                    let tradeAggregations = try self.jsonDecoder.decode(PageResponse<TradeAggregationResponse>.self, from: data)
////                    response(.success(details: tradeAggregations))
//                    //解析数据
//                    let dic = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
//                    //取出_embedded数据
//                    let dict = dic["_embedded"] as! [String: Any]
//                    //取出kline数据
//                    let kArr = dict["records"] as! [[String: Any]]
//                } catch {
//                    response(.failure(error: .parsingResponseFailed(message: error.localizedDescription)))
//                }
//            case .failure(let error):
//                response(.failure(error:error))
//            }
//        }
//    }
}
