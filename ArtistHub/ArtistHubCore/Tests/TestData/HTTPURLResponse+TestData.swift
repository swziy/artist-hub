import Foundation

extension HTTPURLResponse {

    static var ok: HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    }

    static var redirect: HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 300, httpVersion: nil, headerFields: nil)
    }

    static var info: HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 100, httpVersion: nil, headerFields: nil)
    }
}
