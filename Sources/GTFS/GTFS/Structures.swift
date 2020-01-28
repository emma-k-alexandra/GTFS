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

struct Agency: Codable {
    let agencyId: String?
    let agencyName: String
    let agencyUrl: String
    let agencyTimezone: String
    let agencyLang: String?
    let agencyPhone: String?
    let agencyFareUrl: String?
    let agencyEmail: String?
    
    init(line: CSVLine) {
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

struct Stop: Codable {
    let stopId: String
    let stopCode: String?
    let stopName: String?
    let stopDesc: String?
    let stopLat: Double?
    let stopLon: Double?
    let zoneId: String?
    let stopUrl: String?
    let locationType: LocationType?
    let parentStation: String?
    let stopTimezone: String?
    let wheelchairBoarding: WheelchairAccessible?
    let levelId: String?
    let platformCode: String?
    
    init(line: CSVLine) {
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

enum LocationType: Int, Codable {
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

enum WheelchairAccessible: Int, Codable {
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

struct Route {
    let routeId: String
    let agencyId: String?
    let routeShortName: String?
    let routeLongName: String?
    let routeDesc: String?
    let routeType: RouteType
    let routeUrl: String?
    let routeColor: String?
    let routeTextColor: String?
    let routeSortOrder: Int?
    
    init(line: CSVLine) {
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


enum RouteType: Int, Codable {
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

struct Trip: Codable {
    let routeId: String
    let serviceId: String
    let tripId: String
    let tripHeadsign: String?
    let tripShortName: String?
    let directionId: Direction?
    let blockId: String?
    let shapeId: String?
    let wheelchairAccessible: WheelchairAccessible?
    let bikesAllowed: BikesAllowed?
    
    init(line: CSVLine) {
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

enum Direction: Int, Codable {
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

enum BikesAllowed: Int, Codable {
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

struct StopTime: Codable {
    let tripId: String
    let arrivalTime: String?
    let departureTime: String?
    let stopId: String
    let stopSequence: Int
    let stopHeadsign: String?
    let pickupType: PickupType?
    let dropOffType: DropOffType?
    let shapeDistTraveled: Float?
    let timepoint: Timepoint?
    
    init(line: CSVLine) {
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

enum PickupType: Int, Codable {
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

enum DropOffType: Int, Codable {
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

enum Timepoint: Int, Codable {
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

struct GTFSCalendar: Codable {
    let serviceId: String
    let monday: ServiceAvailable
    let tuesday: ServiceAvailable
    let wednesday: ServiceAvailable
    let thursday: ServiceAvailable
    let friday: ServiceAvailable
    let saturday: ServiceAvailable
    let sunday: ServiceAvailable
    let startDate: String
    let endDate: String
    
    init(line: CSVLine) {
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

enum ServiceAvailable: Int, Codable {
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

struct CalendarDate: Codable {
    let serviceId: String
    let date: String
    let exceptionType: ExceptionType
    
    init(line: CSVLine) {
        self.serviceId = line["service_id"]!
        self.date = line["date"]!
        self.exceptionType = ExceptionType.from(line["exception_type"]!)
        
    }
    
}

enum ExceptionType: Int, Codable {
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

struct FareAttribute: Codable {
    let fareId: String
    let price: Float
    let currencyType: String
    let paymentMethod: PaymentMethod
    let transfers: TransfersAllowed
    let agencyId: String?
    let transferDuration: Int?
    
    init(line: CSVLine) {
        self.fareId = line["fare_id"]!
        self.price = Float.from(line["price"]!)!
        self.currencyType = line["currency_type"]!
        self.paymentMethod = PaymentMethod.from(line["payment_method"]!)
        self.transfers = TransfersAllowed.from(line["transfers"]!)
        self.agencyId = line["agency_id"]
        self.transferDuration = Int.from(line["transfer_duration"])
        
    }
    
}

enum PaymentMethod: Int, Codable {
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

enum TransfersAllowed: Int, Codable {
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

struct FareRule: Codable {
    let fareId: String
    let routeId: String?
    let originId: String?
    let destinationId: String?
    let containsId: String?
    
    init(line: CSVLine) {
        self.fareId = line["fare_id"]!
        self.routeId = line["route_id"]
        self.originId = line["origin_id"]
        self.destinationId = line["destination_id"]
        self.containsId = line["contains_id"]
        
    }
    
}

struct Shape: Codable {
    let shapeId: String?
    let shapePtLat: Double
    let shapePtLon: Double
    let shapePtSequence: Int
    let shapeDistTraveled: Float?
    
    init(line: CSVLine) {
        self.shapeId = line["shape_id"]
        self.shapePtLat = Double.from(line["shape_pt_lat"])!
        self.shapePtLon = Double.from(line["shape_pt_lon"])!
        self.shapePtSequence = Int.from(line["shape_pt_sequence"])!
        self.shapeDistTraveled = Float.from(line["shape_dist_traveled"])
        
    }
    
}

struct Frequency: Codable {
    let tripId: String
    let startTime: String
    let endTime: String
    let headwaySecs: Int
    let exactTimes: ExactTimes?
    
    init(line: CSVLine) {
        self.tripId = line["trip_id"]!
        self.startTime = line["start_time"]!
        self.endTime = line["end_time"]!
        self.headwaySecs = Int.from(line["headway_secs"])!
        self.exactTimes = ExactTimes.from(line["exact_times"])
        
    }
    
}

enum ExactTimes: Int, Codable {
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

struct Transfer: Codable {
    let fromStopId: String
    let topStopId: String
    let transferType: TransferType
    let minTransferTime: Int?
    
    init(line: CSVLine) {
        self.fromStopId = line["from_stop_id"]!
        self.topStopId = line["top_stop_id"]!
        self.transferType = TransferType.from(line["transfer_type"]!)
        self.minTransferTime = Int.from(line["min_transfer_time"])
        
    }
    
}

enum TransferType: Int, Codable {
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

struct Pathway: Codable {
    let pathwayId: String
    let fromStopId: String
    let toStopId: String
    let pathwayMode: PathwayMode
    let isBidirectional: Bidirectional
    let length: Float?
    let transversalTime: Int?
    let stairCount: Int?
    let maxSlope: Float?
    let minWidth: Float?
    let signpostedAs: String?
    let reversedSignpostedAs: String?
    
    init(line: CSVLine) {
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

enum Bidirectional: Int, Codable {
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

enum PathwayMode: Int, Codable {
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

struct Level: Codable {
    let levelId: String
    let levelIndex: Float
    let levelName: String?
    
    init(line: CSVLine) {
        self.levelId = line["level_id"]!
        self.levelIndex = Float.from(line["level_index"])!
        self.levelName = line["level_name"]
        
    }
    
}

struct FeedInfo: Codable {
    let feedPublisherName: String
    let feedPublisherUrl: String
    let feedLang: String
    let feedStartDate: String?
    let feedEndDate: String?
    let feedVersion: String?
    let feedContactEmail: String?
    let feedContactUrl: String?
    
    init(line: CSVLine) {
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

struct Translation: Codable {
    let tableName: TableName
    let fieldName: String
    let language: String
    let translation: String
    let recordId: String?
    
    init(line: CSVLine) {
        self.tableName = TableName.from(line["table_name"]!)
        self.fieldName = line["field_name"]!
        self.language = line["language"]!
        self.translation = line["translation"]!
        self.recordId = line["record_id"]
        
    }
    
}

enum TableName: String, Codable {
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

struct Attribution: Codable {
    let attributionId: String?
    let agencyId: String?
    let routeId: String?
    let tripId: String?
    let organizationName: String
    let isProducer: HasRole?
    let isOperator: HasRole?
    let isAuthority: HasRole?
    let attributionUrl: String?
    let attributionEmail: String?
    let attributionPhone: String?
    
    init(line: CSVLine) {
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

enum HasRole: Int, Codable {
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
