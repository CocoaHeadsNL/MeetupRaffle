//
//  MeetupAPI.swift
//  CocoaHeads
//
//  Created by Antoine van der Lee on 08/11/16.
//  Copyright © 2016 alee. All rights reserved.
//

import Foundation
import Moya

let provider = ReactiveSwiftMoyaProvider<MeetupAPI>()

enum MeetupAPI {
    case rsvps(groupName:String, eventId:Int)
}

extension MeetupAPI: TargetType {
    /// The method used for parameter encoding.
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding()
    }

    var baseURL: URL { return URL(string: "https://api.meetup.com")! }
    var path: String {
        switch self {
        case .rsvps(let groupName, let eventId):
            return "/\(groupName)/events/\(eventId)/rsvps"
        }
    }
    var method: Moya.Method {
        switch self {
        case .rsvps(_, _):
            return .get
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .rsvps(_, _):
            return [
                "sig_id": AppSettings.APISettings.sigId, // Make sure these are up to date for your account
                "sig": AppSettings.APISettings.sig,  // Make sure these are up to date for your account
                "photo-host": "public"
            ]
        }
    }
    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
    var task: Task {
        switch self {
        case .rsvps(_, _):
            return .request
        }
    }
    var multipartBody: [MultipartFormData]? {
        // Optional
        return nil
    }
}
