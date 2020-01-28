import Foundation

struct GTFS {
//    private static let TYPE_FOR_FILE_NAME: [String: Any] = [
//        "agency.txt": Agencies.self,
//        "stops.txt": Stops.self,
//        "routes.txt": Routes.self,
//        "trips.txt": Trips.self,
//        "stop_times.txt": StopTimes.self,
//        "calendar.txt": GTFSCalendar.self,
//        "fare_attributes.txt": FareAttributes.self,
//        "fare_rules.txt": FareRules.self,
//        "shapes.txt": Shapes.self,
//        "frequencies.txt": Frequencies.self,
//        "transfers.txt": Transfers.self,
//        "pathways.txt": Pathways.self,
//        "levels.txt": Levels.self,
//        "feed_info": FeedInformation.self,
//        "translations.txt": Translations.self,
//        "attributions.txt": Attributions.self
//    ]
    
    var agencies: [Agency] = []
    var stops: [Stop] = []
    var routes: [Route] = []
    var trips: [Trip] = []
    var stopTimes: [StopTime] = []
    var calendar: [GTFSCalendar] = []
    var calendarDates: [CalendarDate] = []
    var fareAttributes: [FareAttribute] = []
    var fareRules: [FareRule] = []
    var shapes: [Shape] = []
    var frequencies: [Frequency] = []
    var transfers: [Transfer] = []
    var pathways: [Pathway] = []
    var levels: [Level] = []
    var feedInformation: [FeedInfo] = []
    var translations: [Translation] = []
    var attributions: [Attribution] = []
    
    init(path: String) throws {
        let filenamesInDirectory = try FileManager.default.contentsOfDirectory(atPath: path)
        let url = URL(fileURLWithPath: path)
        
        for filename in filenamesInDirectory {
            let fileUrl = url.appendingPathComponent(filename)
            let reader = try CSVReader(path: fileUrl)
            
            for line in reader {
                switch filename {
                case "agency.txt":
                    self.agencies.append(Agency(line: line))
                case "stops.txt":
                    self.stops.append(Stop(line: line))
                case "routes.txt":
                    self.routes.append(Route(line: line))
                case "trips.txt":
                    self.trips.append(Trip(line: line))
                case "stop_times.txt":
                    self.stopTimes.append(StopTime(line: line))
                case "calendar.txt":
                    self.calendar.append(GTFSCalendar(line: line))
                case "calendar_dates.txt":
                    self.calendarDates.append(CalendarDate(line: line))
                case "fare_attributes.txt":
                    self.fareAttributes.append(FareAttribute(line: line))
                case "fare_rules.txt":
                    self.fareRules.append(FareRule(line: line))
                case "shapes.txt":
                    self.shapes.append(Shape(line: line))
                case "frequencies.txt":
                    self.frequencies.append(Frequency(line: line))
                case "transfers.txt":
                    self.transfers.append(Transfer(line: line))
                case "pathways.txt":
                    self.pathways.append(Pathway(line: line))
                case "levels.txt":
                    self.levels.append(Level(line: line))
                case "feed_info.txt":
                    self.feedInformation.append(FeedInfo(line: line))
                case "translations.txt":
                    self.translations.append(Translation(line: line))
                case "attributions.txt":
                    self.attributions.append(Attribution(line: line))
                default:
                    continue
                }
                
            }
            
        }
        
    }
    
}
