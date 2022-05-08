//
//  NetworkClient.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 15/04/22.
//

import Foundation

class NetworkClient: NSObject {
    
    var session: URLSession!
    //TODO: This token can be fetched from firebase
    let token = "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"
    var cacheRepository: CacheRepositoryProtocol!
    
    public convenience init(cacheRepository: CacheRepositoryProtocol) {
        self.init()
        self.cacheRepository = cacheRepository
    }
    
    public override init() {
        super.init()
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10.0
        sessionConfig.timeoutIntervalForResource = 10.0
        sessionConfig.waitsForConnectivity = true
        self.session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
    }
    
    public func request<T: Codable, U: Codable>(
        type: T.Type,
        request: RequestProtocol,
        errorType: U.Type,
        completion: @escaping (T) -> (),
        failure: @escaping (NetworkError) -> ()
    ) {
        switch request.localCachePolicy {
        case .loadFromCache:
            loadFromCache(
                type: type,
                request: request,
                errorType: errorType,
                completion: completion,
                failure: failure
            )
    
        case .loadFromNetworkNoCache:
            loadFromNetwork(
                type: type,
                request: request,
                errorType: errorType,
                shouldCache: false,
                completion: completion,
                failure: failure
            )
            
        case .loadFromCacheThenNetwork:
            loadFromCache(
                type: type,
                request: request,
                errorType: errorType,
                completion: completion,
                failure: failure
            )
            
            loadFromNetwork(
                type: type,
                request: request,
                errorType: errorType,
                shouldCache: true,
                completion: nil,
                failure: nil
            )
            
        case .loadFromNetworkSaveCache:
            loadFromNetwork(
                type: type,
                request: request,
                errorType: errorType,
                shouldCache: true,
                completion: completion,
                failure: failure
            )
        }
    }
    
    private func loadFromCache<T: Codable, U: Codable>(
        type: T.Type,
        request: RequestProtocol,
        errorType: U.Type,
        completion: @escaping (T) -> (),
        failure: @escaping (NetworkError) -> ()
    ) {
        if let cachedData = cacheRepository.getCache(for: request.requestSha256()),
           let cachedModel = decode(type: type, from: cachedData) {
            completion(cachedModel)
        } else {
            loadFromNetwork(
                type: type,
                request: request,
                errorType: errorType,
                shouldCache: true,
                completion: completion,
                failure: failure
            )
        }
    }
    
    func loadFromNetwork<T: Codable, U: Codable>(
        type: T.Type,
        request: RequestProtocol,
        errorType: U.Type,
        shouldCache: Bool,
        completion: ((T) -> ())?,
        failure: ((NetworkError) -> ())?
    ) {
        requestData(request: request, errorType: errorType) { [weak self] result in
            switch result {
            case .success(.model(let data)):
                if let model = self?.decode(type: type, from: data) {
                    if shouldCache {
                        self?.cacheRepository.setCache(for: request.requestSha256(), data: data)
                    }
                    completion?(model)
                } else {
                    let statusCode = FailResponse<U>.parse.code
                    let errorMessage = FailResponse<U>.parse.errorDescription
                    failure?(NetworkError(statusCode: statusCode, errorMessage: errorMessage))
                }
                
            case .success(.empty):
                let statusCode = FailResponse<U>.empty.code
                let errorMessage = FailResponse<U>.empty.errorDescription
                failure?(NetworkError(statusCode: statusCode, errorMessage: errorMessage))
                
            case .failure(let error):
                failure?(NetworkError(statusCode: error.code, errorMessage: error.errorDescription))
            }
        }
    }
    
    private func requestData<T: Decodable>(
        request: RequestProtocol,
        errorType: T.Type,
        completion: ((NetworkResult<Data, T>) -> ())?
    ) {
        let urlRequest = self.urlRequest(from: request)
        
        let task = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            self?.handleResponse(
                data: data,
                response: httpResponse,
                error: error,
                errorType: errorType,
                completion: completion
            )
        }
        
        task.resume()
    }
    
    public func getUrlRequest(_ request: RequestProtocol) -> URLRequest? {
        return urlRequest(from: request)
    }
    
    private func urlRequest(from request: RequestProtocol) -> URLRequest {
        let encodedParameters = self.encodedParameters(for: request)
        let urlString = request.path.isEmpty ?  request.baseURL : "\(request.baseURL)\(request.path)"
        let url = URL(string: urlString)!
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        if(urlComponents == nil) {
            urlComponents = URLComponents(string: request.baseURL)
            urlComponents?.path = request.path
        }
        
        if case .queryItems(let queryItems) = encodedParameters {
            urlComponents?.queryItems = queryItems
        } else if !request.urlParameters.isEmpty {
            urlComponents?.queryItems = request.urlParameters.map { URLQueryItem(name: $0, value: $1 as? String) }
        }
        
        var urlRequest = URLRequest(url: urlComponents?.url ?? url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.addValue (
            Locale.current.identifier.replacingOccurrences(of: "_", with: "-"),
            forHTTPHeaderField: "Accept-Language"
        )
        
        request.headers.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        if case .httpBody(let httpBody) = encodedParameters {
            urlRequest.httpBody = httpBody
        }
        
        if request.requiresTokenInBody {
            urlRequest.addValue("token \(token)", forHTTPHeaderField: "Authorization")
        }
                
        return urlRequest
    }
    
    private func encodedParameters(for request: RequestProtocol) -> ParametersEncoding.EncodedParameters {
        switch request.task {
        case .plain, .upload: return .unknown
        case .parameters(let parametersConvertible):
            return request.parametersEncoding.encode(parametersConvertible: parametersConvertible)
        }
    }
    
    private func handleResponse<T: Decodable>(
        data: Data?,
        response: HTTPURLResponse?,
        error: Error?,
        errorType: T.Type,
        completion: ((NetworkResult<Data, T>) -> ())?) {
        guard let statusCode = response?.statusCode
        else {
            completion?(.failure(.unknown))
            return
        }
        let defaultNetworkError = NetworkError(statusCode: statusCode, errorMessage: "Network request failed.")
        
        switch (statusCode, error) {
        case (let statusCode, _) where (200...299).contains(statusCode):
            if let data = data, !data.isEmpty {
                completion?(.success(.model(data)))
            } else {
                completion?(.success(.empty))
            }
            
        case (let statusCode, _) where (301...302).contains(statusCode):
            completion?(.failure(.redirect(response?.allHeaderFields["Location"] as? String)))
            
        case (let statusCode, _) where (400...600).contains(statusCode):
            if let data = data, !data.isEmpty {
                if let networkModel = decode(type: errorType, from: data) {
                    if let networkError = networkModel as? NetworkError {
                        completion?(.failure(.error(networkError)))
                    } else {
                        completion?(.failure(.error(defaultNetworkError)))
                    }
                } else {
                    completion?(.failure(.error(defaultNetworkError)))
                }
            } else {
                completion?(.failure(.error(defaultNetworkError)))
            }
            
        case (_, let error as NSError) where error.code == NSURLErrorNotConnectedToInternet:
            completion?(.failure(.error(NetworkError(statusCode: error.code, errorMessage: error.localizedDescription))))
            
        case (_, let error as NSError) where error.code == NSURLErrorTimedOut:
            completion?(.failure(.error(NetworkError(statusCode: error.code, errorMessage: error.localizedDescription))))
            
        case (_, let error as NSError) where error.code == NSURLErrorCancelled:
            completion?(.failure(.error(defaultNetworkError)))
        default:
            completion?(.failure(.unknown))
        }
    }
    
    private func decode<T: Decodable>(type: T.Type, from data: Data) -> T? {
        if let data = data as? T {
            return data
        } else {
            return JSONDecoder().decodeJSON(type: type, data: data)
        }
    }
}

extension NetworkClient: URLSessionTaskDelegate {

    func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
        NotificationCenter.default.post(name: kReachabilityChangedNotification, object: nil, userInfo: ["isConnected": false])
    }
}
