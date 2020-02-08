//
//  Structures.swift
//  
//
//  Created by Emma K Alexandra on 1/28/20.
//

import Foundation

extension Double {
    static func from(_ string: String?) -> Double? {
        if let string = string {
            return Double(string)
            
        } else {
            return nil
            
        }
        
    }
    
}

extension Int {
    static func from(_ string: String?) -> Int? {
        if let string = string {
            return Int(string)
            
        } else {
            return nil
            
        }
        
    }
    
}

extension Float {
    static func from(_ string: String?) -> Float? {
        if let string = string {
            return Float(string)
            
        } else {
            return nil
            
        }
        
    }
    
}

protocol FromCSVLine {
    init(line: CSVLine)

}

public struct Agency: Codable, FromCSVLine {
    public let agencyId: String?
    public let agencyName: String
    public let agencyUrl: String
    public let agencyTimezone: String
    public let agencyLang: String?
    public let agencyPhone: String?
    public let agencyFareUrl: String?
    public let agencyEmail: String?
    
    public init(line: CSVLine) {
        self.agencyId = line["agency_id"]
        self.agencyName = line["agency_name"]!
        self.agencyUrl = line["agency_url"]!
        self.agencyTimezone = line["agency_timezone"]!
        self.agencyLang = line["agency_lang"]
        self.agencyPhone = line["agency_phone"]
        self.agencyFareUrl = line["agency_fare_url"]
        self.agencyEmail = line["agency_email"]
        
    }
    
}

public struct Stop: Codable, FromCSVLine {
    public let stopId: String
    public let stopCode: String?
    public let stopName: String?
    public let stopDesc: String?
    public let stopLat: Double?
    public let stopLon: Double?
    public let zoneId: String?
    public let stopUrl: String?
    public let locationType: LocationType?
    public let parentStation: String?
    public let stopTimezone: String?
    public let wheelchairBoarding: WheelchairAccessible?
    public let levelId: String?
    public let platformCode: String?
    
    public init(line: CSVLine) {
        self.stopId = line["stop_id"]!
        self.stopCode = line["stop_code"]
        self.stopName = line["stop_name"]
        self.stopDesc = line["stop_desc"]
        self.stopLat = Double.from(line["stop_lat"])
        self.stopLon = Double.from(line["stop_lon"])
        self.zoneId = line["zone_id"]
        self.stopUrl = line["stop_url"]
        self.locationType = LocationType.from(line["location_type"])
        self.parentStation = line["parent_station"]
        self.stopTimezone = line["stop_timezone"]
        self.wheelchairBoarding = WheelchairAccessible.from(line["wheelchair_boarding"])
        self.levelId = line["level_id"]
        self.platformCode = line["platform_code"]
        
    }
    
}

public enum LocationType: Int, Codable {
    case stop = 0
    case station = 1
    case entranceOrExit = 2
    case genericNode = 3
    case boardingArea = 4
    
    static func from(_ string: String?) -> LocationType? {
        if let string = string {
            if let int = Int(string) {
                return LocationType(rawValue: int) ?? .stop
                
            } else {
                return .stop
                
            }
            
        } else {
            return nil
            
        }
        
    }
    
}

public enum WheelchairAccessible: Int, Codable {
    case noInformation = 0
    case wheelchairAccessible = 1
    case notWheelchairAccessible = 2
    
    static func from(_ string: String?) -> WheelchairAccessible? {
        if let string = string {
            if let int = Int(string) {
                return WheelchairAccessible(rawValue: int) ?? .noInformation
                
            } else {
                return .noInformation
                
            }
            
        } else {
            return nil
            
        }
        
    }
    
}

public struct Route: Codable, FromCSVLine {
    public let routeId: String
    public let agencyId: String?
    public let routeShortName: String?
    public let routeLongName: String?
    public let routeDesc: String?
    public let routeType: RouteType
    public let routeUrl: String?
    public let routeColor: String?
    public let routeTextColor: String?
    public let routeSortOrder: Int?
    
    public init(line: CSVLine) {
        self.routeId = line["route_id"]!
        self.agencyId = line["agency_id"]
        self.routeShortName = line["route_short_name"]
        self.routeLongName = line["route_long_name"]
        self.routeDesc = line["route_desc"]
        self.routeType = RouteType.from(line["route_type"])!
        self.routeUrl = line["route_url"]
        self.routeColor = line["route_color"]
        self.routeTextColor = line["route_text_color"]
        self.routeSortOrder = Int.from(line["route_sort_order"])
        
    }
    
}


public enum RouteType: Int, Codable {
    case tramStreetcaseOrLightRail = 0
    case subwayOrMetro = 1
    case rail = 2
    case bus = 3
    case ferry = 4
    case cableCar = 5
    case gondolaOrSuspendedCableCar = 6
    case funicular = 7
    
    static func from(_ string: String?) -> RouteType? {
        if let string = string {
            if let int = Int(string) {
                return RouteType(rawValue: int) ?? .tramStreetcaseOrLightRail
                
            } else {
                return .tramStreetcaseOrLightRail
                
            }
            
        } else {
            return nil
            
        }
        
    }
    
}

public struct Trip: Codable, FromCSVLine {
    public let routeId: String
    public let serviceId: String
    public let tripId: String
    public let tripHeadsign: String?
    public let tripShortName: String?
    public let directionId: Direction?
    public let blockId: String?
    public let shapeId: String?
    public let wheelchairAccessible: WheelchairAccessible?
    public let bikesAllowed: BikesAllowed?
    
    public init(line: CSVLine) {
        self.routeId = line["route_id"]!
        self.serviceId = line["service_id"]!
        self.tripId = line["trip_id"]!
        self.tripHeadsign = line["trip_headsign"]
        self.tripShortName = line["trip_short_name"]
        self.directionId = Direction.from(line["direction_id"])
        self.blockId = line["block_id"]
        self.shapeId = line["shape_id"]
        self.wheelchairAccessible = WheelchairAccessible.from(line["wheelchair_accessible"])
        self.bikesAllowed = BikesAllowed.from(line["bikes_allowed"])
        
    }
    
}

public enum Direction: Int, Codable {
    case travelInOneDirection = 0
    case travelInOppositeDirection = 1
    
    static func from(_ string: String?) -> Direction? {
        if let string = string {
            if let int = Int(string) {
                return Direction(rawValue: int) ?? .travelInOneDirection
                
            } else {
                return .travelInOneDirection
                
            }
            
        } else {
            return nil
            
        }
        
    }
    
}

public enum BikesAllowed: Int, Codable {
    case noBikeInformation = 0
    case atleastOneBicycle = 1
    case noBicyclesAllowed = 2
    
    static func from(_ string: String?) -> BikesAllowed? {
        if let string = string {
            if let int = Int(string) {
                return BikesAllowed(rawValue: int) ?? .noBikeInformation
                
            } else {
                return .noBikeInformation
                
            }
             
        } else {
            return nil
            
        }
        
    }
    
}

public struct StopTime: Codable, FromCSVLine {
    public let tripId: String
    public let arrivalTime: String?
    public let departureTime: String?
    public let stopId: String
    public let stopSequence: Int
    public let stopHeadsign: String?
    public let pickupType: PickupType?
    public let dropOffType: DropOffType?
    public let shapeDistTraveled: Float?
    public let timepoint: Timepoint?
    
    public init(line: CSVLine) {
        self.tripId = line["trip_id"]!
        self.arrivalTime = line["arrival_time"]
        self.departureTime = line["departure_time"]
        self.stopId = line["stop_id"]!
        self.stopSequence = Int(line["stop_sequence"]!)!
        self.stopHeadsign = line["stop_headsign"]
        self.pickupType = PickupType.from(line["pickup_type"])
        self.dropOffType = DropOffType.from(line["drop_off_type"])
        self.shapeDistTraveled = Float.from(line["shape_dist_traveled"])
        self.timepoint = Timepoint.from(line["timepoint"])
        
    }
    
}

public enum PickupType: Int, Codable {
    case regularlyScheduled = 0
    case noPickupAvailable = 1
    case phoneAgencyForPickup = 2
    case coordinateWithDriver = 3
    
    static func from(_ string: String?) -> PickupType? {
        if let string = string {
            if let int = Int(string) {
                return PickupType(rawValue: int) ?? .regularlyScheduled
                
            } else {
                return .regularlyScheduled
                
            }
            
        } else {
            return nil
            
        }
        
    }
    
}

public enum DropOffType: Int, Codable {
    case regularlyScheduled = 0
    case noDropOffAvailable = 1
    case phoneAgencyForDropOff = 2
    case coordinateWithDriver = 3
    
    static func from(_ string: String?) -> DropOffType? {
        if let string = string {
            if let int = Int(string) {
                return DropOffType(rawValue: int) ?? .regularlyScheduled
                
            } else {
                return .regularlyScheduled
                
            }
            
        } else {
            return nil
            
        }
        
    }
    
}

public enum Timepoint: Int, Codable {
    case approximate = 0
    case exact = 1
    
    static func from(_ string: String?) -> Timepoint? {
        if let string = string {
            if let int = Int(string) {
                return Timepoint(rawValue: int) ?? .exact
                
            } else {
                return .exact
                
            }
        } else {
            return nil
            
        }
    
    }
        
}

public struct GTFSCalendar: Codable, FromCSVLine {
    public let serviceId: String
    public let monday: ServiceAvailable
    public let tuesday: ServiceAvailable
    public let wednesday: ServiceAvailable
    public let thursday: ServiceAvailable
    public let friday: ServiceAvailable
    public let saturday: ServiceAvailable
    public let sunday: ServiceAvailable
    public let startDate: String
    public let endDate: String
    
    public init(line: CSVLine) {
        self.serviceId = line["service_id"]!
        self.monday = ServiceAvailable.from(line["monday"]!)
        self.tuesday = ServiceAvailable.from(line["tuesday"]!)
        self.wednesday = ServiceAvailable.from(line["wednesday"]!)
        self.thursday = ServiceAvailable.from(line["thursday"]!)
        self.friday = ServiceAvailable.from(line["friday"]!)
        self.saturday = ServiceAvailable.from(line["saturday"]!)
        self.sunday = ServiceAvailable.from(line["sunday"]!)
        self.startDate = line["start_date"]!
        self.endDate = line["end_date"]!
        
    }
    
}

public enum ServiceAvailable: Int, Codable {
    case notAvailableForAll = 0
    case availableForAll = 1
    
    static func from(_ string: String) -> ServiceAvailable {
        if let int = Int(string) {
            return ServiceAvailable(rawValue: int) ?? .notAvailableForAll
            
        } else {
            return .notAvailableForAll
            
        }
        
    }
    
}

public struct CalendarDate: Codable, FromCSVLine {
    public let serviceId: String
    public let date: String
    public let exceptionType: ExceptionType
    
    public init(line: CSVLine) {
        self.serviceId = line["service_id"]!
        self.date = line["date"]!
        self.exceptionType = ExceptionType.from(line["exception_type"]!)
        
    }
    
}

public enum ExceptionType: Int, Codable {
    case serviceAdded = 1
    case serviceRemoved = 2
    
    static func from(_ string: String) -> ExceptionType {
        if let int = Int(string) {
            return ExceptionType(rawValue: int) ?? .serviceAdded
            
        } else {
            return .serviceAdded
            
        }
        
    }
    
}

public struct FareAttribute: Codable, FromCSVLine {
    public let fareId: String
    public let price: Float
    public let currencyType: String
    public let paymentMethod: PaymentMethod
    public let transfers: TransfersAllowed
    public let agencyId: String?
    public let transferDuration: Int?
    
    public init(line: CSVLine) {
        self.fareId = line["fare_id"]!
        self.price = Float.from(line["price"]!)!
        self.currencyType = line["currency_type"]!
        self.paymentMethod = PaymentMethod.from(line["payment_method"]!)
        self.transfers = TransfersAllowed.from(line["transfers"]!)
        self.agencyId = line["agency_id"]
        self.transferDuration = Int.from(line["transfer_duration"])
        
    }
    
}

public enum PaymentMethod: Int, Codable {
    case farePaidOnBoard = 0
    case fareMustBePaidBeforeBoarding = 1
    
    static func from(_ string: String) -> PaymentMethod {
        if let int = Int(string) {
            return PaymentMethod(rawValue: int) ?? .farePaidOnBoard
            
        } else {
            return .farePaidOnBoard
            
        }
        
    }
    
}

public enum TransfersAllowed: Int, Codable {
    case noTransfers = 0
    case oneTransfer = 1
    case twoTransfers = 2
    case unlimitedTransfers = -1
    
    static func from(_ string: String) -> TransfersAllowed {
        if let int = Int(string) {
            return TransfersAllowed(rawValue: int) ?? .unlimitedTransfers
            
        } else {
            return .unlimitedTransfers
            
        }
        
    }
    
}

public struct FareRule: Codable, FromCSVLine {
    public let fareId: String
    public let routeId: String?
    public let originId: String?
    public let destinationId: String?
    public let containsId: String?
    
    public init(line: CSVLine) {
        self.fareId = line["fare_id"]!
        self.routeId = line["route_id"]
        self.originId = line["origin_id"]
        self.destinationId = line["destination_id"]
        self.containsId = line["contains_id"]
        
    }
    
}

public struct Shape: Codable, FromCSVLine {
    public let shapeId: String?
    public let shapePtLat: Double
    public let shapePtLon: Double
    public let shapePtSequence: Int
    public let shapeDistTraveled: Float?
    
    public init(line: CSVLine) {
        self.shapeId = line["shape_id"]
        self.shapePtLat = Double.from(line["shape_pt_lat"])!
        self.shapePtLon = Double.from(line["shape_pt_lon"])!
        self.shapePtSequence = Int.from(line["shape_pt_sequence"])!
        self.shapeDistTraveled = Float.from(line["shape_dist_traveled"])
        
    }
    
}

public struct Frequency: Codable, FromCSVLine {
    public let tripId: String
    public let startTime: String
    public let endTime: String
    public let headwaySecs: Int
    public let exactTimes: ExactTimes?
    
    public init(line: CSVLine) {
        self.tripId = line["trip_id"]!
        self.startTime = line["start_time"]!
        self.endTime = line["end_time"]!
        self.headwaySecs = Int.from(line["headway_secs"])!
        self.exactTimes = ExactTimes.from(line["exact_times"])
        
    }
    
}

public enum ExactTimes: Int, Codable {
    case frequencyBasedTrips = 0
    case scheduleBasedTrips = 1
    
    static func from(_ string: String?) -> ExactTimes? {
        if let string = string {
            if let int = Int(string) {
                return ExactTimes(rawValue: int) ?? .frequencyBasedTrips
                
            } else {
                return .frequencyBasedTrips
                
            }
            
        } else {
            return .frequencyBasedTrips
            
        }
        
    }
    
}

public struct Transfer: Codable, FromCSVLine {
    public let fromStopId: String
    public let topStopId: String
    public let transferType: TransferType
    public let minTransferTime: Int?
    
    public init(line: CSVLine) {
        self.fromStopId = line["from_stop_id"]!
        self.topStopId = line["top_stop_id"]!
        self.transferType = TransferType.from(line["transfer_type"]!)
        self.minTransferTime = Int.from(line["min_transfer_time"])
        
    }
    
}

public enum TransferType: Int, Codable {
    case recommendedTransferPoint = 0
    case timeTransferPoint = 1
    case minimumTimeTransfer = 2
    case transferNotPossible = 3
    
    static func from(_ string: String) -> TransferType {
        if let int = Int(string) {
            return TransferType(rawValue: int) ?? .recommendedTransferPoint
            
        } else {
            return .recommendedTransferPoint
            
        }
        
    }
    
}

public struct Pathway: Codable, FromCSVLine {
    public let pathwayId: String
    public let fromStopId: String
    public let toStopId: String
    public let pathwayMode: PathwayMode
    public let isBidirectional: Bidirectional
    public let length: Float?
    public let transversalTime: Int?
    public let stairCount: Int?
    public let maxSlope: Float?
    public let minWidth: Float?
    public let signpostedAs: String?
    public let reversedSignpostedAs: String?
    
    public init(line: CSVLine) {
        self.pathwayId = line["pathway_id"]!
        self.fromStopId = line["from_stop_id"]!
        self.toStopId = line["to_stop_id"]!
        self.pathwayMode = PathwayMode.from(line["pathway_mode"]!)
        self.isBidirectional = Bidirectional.from(line["is_bidirectional"]!)
        self.length = Float.from(line["length"])
        self.transversalTime = Int.from(line["transversal_time"])
        self.stairCount = Int.from(line["stair_count"])
        self.maxSlope = Float.from(line["max_slope"])
        self.minWidth = Float.from(line["min_width"])
        self.signpostedAs = line["signposted_as"]
        self.reversedSignpostedAs = line["reversed_signposted_as"]
        
    }
    
}

public enum Bidirectional: Int, Codable {
    case unidirectional = 0
    case bidirectional = 1
    
    static func from(_ string: String) -> Bidirectional {
        if let int = Int(string) {
            return Bidirectional(rawValue: int) ?? .unidirectional
            
        } else {
            return .unidirectional
            
        }
        
    }
    
}

public enum PathwayMode: Int, Codable {
    case walkway = 1
    case stairs = 2
    case movingSidewalkOrTravelator = 3
    case escalator = 4
    case elevator = 5
    case fareGate = 6
    
    static func from(_ string: String) -> PathwayMode {
        if let int = Int(string) {
            return PathwayMode(rawValue: int) ?? .walkway
            
        } else {
            return .walkway
            
        }
        
    }
    
}

public struct Level: Codable, FromCSVLine {
    public let levelId: String
    public let levelIndex: Float
    public let levelName: String?
    
    public init(line: CSVLine) {
        self.levelId = line["level_id"]!
        self.levelIndex = Float.from(line["level_index"])!
        self.levelName = line["level_name"]
        
    }
    
}

public struct FeedInfo: Codable, FromCSVLine {
    public let feedPublisherName: String
    public let feedPublisherUrl: String
    public let feedLang: String
    public let feedStartDate: String?
    public let feedEndDate: String?
    public let feedVersion: String?
    public let feedContactEmail: String?
    public let feedContactUrl: String?
    
    public init(line: CSVLine) {
        self.feedPublisherName = line["feed_publisher_name"]!
        self.feedPublisherUrl = line["feed_publisher_url"]!
        self.feedLang = line["feed_lang"]!
        self.feedStartDate = line["feed_start_date"]
        self.feedEndDate = line["feed_end_date"]
        self.feedVersion = line["feed_version"]
        self.feedContactEmail = line["feed_contact_email"]
        self.feedContactUrl = line["feed_contact_url"]
        
    }
    
}

public struct Translation: Codable, FromCSVLine {
    public let tableName: TableName
    public let fieldName: String
    public let language: String
    public let translation: String
    public let recordId: String?
    
    public init(line: CSVLine) {
        self.tableName = TableName.from(line["table_name"]!)
        self.fieldName = line["field_name"]!
        self.language = line["language"]!
        self.translation = line["translation"]!
        self.recordId = line["record_id"]
        
    }
    
}

public enum TableName: String, Codable {
    case agency = "agency"
    case stops = "stops"
    case routes = "routes"
    case trips = "trips"
    case stopTimes = "stop_times"
    case feedInfo = "feed_info"
    
    static func from(_ string: String) -> TableName {
        return TableName(rawValue: string) ?? .agency
        
    }
    
}

public struct Attribution: Codable, FromCSVLine {
    public let attributionId: String?
    public let agencyId: String?
    public let routeId: String?
    public let tripId: String?
    public let organizationName: String
    public let isProducer: HasRole?
    public let isOperator: HasRole?
    public let isAuthority: HasRole?
    public let attributionUrl: String?
    public let attributionEmail: String?
    public let attributionPhone: String?
    
    public init(line: CSVLine) {
        self.attributionId = line["attribution_id"]
        self.agencyId = line["agency_id"]
        self.routeId = line["route_id"]
        self.tripId = line["trip_id"]
        self.organizationName = line["organization_name"]!
        self.isProducer = HasRole.from(line["is_producer"])
        self.isOperator = HasRole.from(line["is_operator"])
        self.isAuthority = HasRole.from(line["is_authority"])
        self.attributionUrl = line["attribution_url"]
        self.attributionEmail = line["attribution_email"]
        self.attributionPhone = line["attribution_phone"]
        
    }
    
}

public enum HasRole: Int, Codable {
    case organizationDoesNotHaveRole = 0
    case organizationDoesHaveRole = 1
    
    static func from(_ string: String?) -> HasRole? {
        if let string = string {
            if let int = Int(string) {
                return HasRole(rawValue: int) ?? .organizationDoesNotHaveRole
                
            } else {
                return .organizationDoesNotHaveRole
                
            }
            
        } else {
            return .organizationDoesNotHaveRole
            
        }
        
    }
    
}
