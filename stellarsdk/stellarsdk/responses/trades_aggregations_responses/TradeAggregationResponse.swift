//
//  TradeAggregationResponse.swift
//  stellarsdk
//
//  Created by Istvan Elekes on 2/8/18.
//  Copyright © 2018 Soneso. All rights reserved.
//

import Foundation

///  Represents a trade aggregation response.
///  See [Horizon API](https://www.stellar.org/developers/horizon/reference/resources/trade_aggregation.html "Trade Aggregation")
public class TradeAggregationResponse: NSObject, Decodable {
    
    /// start time for this trade_aggregation. Represented as milliseconds since epoch.
    public var timestamp:Int64
    
    /// total number of trades aggregated.
    public var tradeCount:Int
    
    /// total volume of base asset.
    public var baseVolume:String
    
    /// total volume of counter asset.
    public var counterVolume:String
    
    /// weighted average price of counter asset in terms of base asset.
    public var averagePrice:String
    
    /// highest price for this time period.
    public var highPrice:String
    
    /// lowest price for this time period.
    public var lowPrice:String
    
    /// price as seen on first trade aggregated.
    public var openPrice:String
    
    /// price as seen on last trade aggregated.
    public var closePrice:String
    
    public var highR: [String:String]
    public var lowR: [String:String]
    public var openR: [String:String]
    public var closeR: [String:String]
    
    private enum CodingKeys: String, CodingKey {
        
        case timestamp
        case tradeCount = "trade_count"
        case baseVolume = "base_volume"
        case counterVolume = "counter_volume"
        case averagePrice = "avg"
        case highPrice = "high"
        case lowPrice = "low"
        case openPrice = "open"
        case closePrice = "close"
        case highR = "high_r"
        case lowR = "low_r"
        case openR = "open_r"
        case closeR = "close_r"
    }
    
    /**
     Initializer - creates a new instance by decoding from the given decoder.
     
     - Parameter decoder: The decoder containing the data
     */
    public required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        timestamp = try values.decode(Int64.self, forKey: .timestamp)
        tradeCount = try values.decode(Int.self, forKey: .tradeCount)
        baseVolume = try values.decode(String.self, forKey: .baseVolume)
        counterVolume = try values.decode(String.self, forKey: .counterVolume)
        averagePrice = try values.decode(String.self, forKey: .averagePrice)
        highPrice = try values.decode(String.self, forKey: .highPrice)
        lowPrice = try values.decode(String.self, forKey: .lowPrice)
        openPrice = try values.decode(String.self, forKey: .openPrice)
        closePrice = try values.decode(String.self, forKey: .closePrice)
        highR = try values.decode([String: String].self, forKey: .highR)
        lowR = try values.decode([String: String].self, forKey: .lowR)
        openR = try values.decode([String: String].self, forKey: .openR)
        closeR = try values.decode([String: String].self, forKey: .closeR)
    }
}
