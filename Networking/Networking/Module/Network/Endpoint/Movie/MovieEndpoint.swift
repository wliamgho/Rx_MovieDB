//
//  MovieEndpoint.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import Alamofire

public enum MovieEndpoint: Endpoint, URLRequestConvertible {
    case getNowPlaying(page: Int)
    case getPopular(page: Int)
    case getUpcoming(page: Int)
    case getDetail(id: Int)

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        switch self {
        case .getNowPlaying:
            return "/3/movie/now_playing"
        case .getPopular:
            return "/3/movie/popular"
        case .getUpcoming:
            return "/3/movie/upcoming"
        case .getDetail(let id):
            return "/3/movie/\(id)"
        }
    }

    var params: [String: Any]? {
        switch self {
        case .getNowPlaying(let page),
             .getPopular(let page),
             .getUpcoming(let page):
            return ["page": page]
        case .getDetail:
            return nil
        }
    }

    public func asURLRequest() throws -> URLRequest {
        var urlRequest = request
        switch self {
        default:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        }
        return urlRequest
    }
}
