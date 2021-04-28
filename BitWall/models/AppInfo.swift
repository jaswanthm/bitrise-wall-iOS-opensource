
// AppInfo.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let appInfo = try? newJSONDecoder().decode(AppInfo.self, from: jsonData)

import Foundation

// MARK: - AppInfo
struct AppInfo: Codable {
    let appName, packageName, versionCode, versionName: String
    let minSDKVersion: String

    enum CodingKeys: String, CodingKey {
        case appName = "app_name"
        case packageName = "package_name"
        case versionCode = "version_code"
        case versionName = "version_name"
        case minSDKVersion = "min_sdk_version"
    }
}
