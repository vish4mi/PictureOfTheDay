//
//  APIResult.swift
//  PRViewer
//
//  Created by Vishal Bhadade on 15/04/22.
//

import Foundation

public typealias NetworkResult<T: Codable, U: Codable> = Result<SuccessResponse<T>, FailResponse<U>>
