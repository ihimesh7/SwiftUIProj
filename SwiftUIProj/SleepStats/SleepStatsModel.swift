//
//  SleepStatsModel.swift
//  SwiftUIProj
//
//  Created by Himesh on 7/28/22.
//

import Foundation

// MARK: - Sleep
struct SleepStats: Codable {
    let sleepData: [String: SleepStatsDatum]?
    
    enum CodingKeys: String, CodingKey {
        case sleepData = "sleep_data"
    }
}

// MARK: - SleepDatum
struct SleepStatsDatum: Codable {
    let userID, source, nightOf: String?
    let heartRateVariability, heartRate: StatsHeartRate?
    let duration, wakeTimeAfterSleepOnset: StatsDuration?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case source
        case nightOf = "night_of"
        case heartRateVariability = "heart_rate_variability"
        case heartRate = "heart_rate"
        case duration
        case wakeTimeAfterSleepOnset = "wake_time_after_sleep_onset"
    }
}

// MARK: - Duration
struct StatsDuration: Codable {
    let unit: DurationUnit?
    let value: String?
}

enum DurationUnit: String, Codable {
    case m = "m"
    case s = "s"
}

// MARK: - HeartRate
struct StatsHeartRate: Codable {
    let unit: HeartRateUnit?
    let mean, median, min, max: String?
    let sampleCount: Int?
    let standardDeviation: String?
    
    enum CodingKeys: String, CodingKey {
        case unit, mean, median, min, max
        case sampleCount = "sample_count"
        case standardDeviation = "standard_deviation"
    }
}

enum HeartRateUnit: String, Codable {
    case bpm = "bpm"
    case ms = "ms"
}

