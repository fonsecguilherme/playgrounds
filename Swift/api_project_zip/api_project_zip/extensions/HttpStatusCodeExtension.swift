//
//  HttpStatusCodeExtension.swift
//  api_project_zip
//
//  Created by Guilherme Fonseca on 20/04/25.
//

import Foundation

extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
