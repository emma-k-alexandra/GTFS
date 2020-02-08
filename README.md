# GTFS

Static and real time [GTFS](https://github.com/google/transit/blob/master/gtfs/spec/en/reference.md) structures for Swift.

## Note
This package is intentionally left as a simple converter into GTFS-reference exact structures. Individual GTFS and GTFS-RT data feeds vary and you will want to build on top of the provided structures for more convient usage with your specific data.

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
  - [Getting Started](#getting-started)
  - [GTFS](#gtfs)
  - [GTFS-RT](#gtfs-rt)
  - [Design](#design)
- [Dependencies](#dependencies)
- [Testing](#testing)
- [Contact](#contact)
- [License](#license)

## Requirements
- Swift 5.1? Untested on lower versions of Swift.

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/emma-k-alexandra/GTFS.git", from: "1.0.0")
]
```
Add the dependency `GTFS` to your target.


## Usage

### Getting Started

#### GTFS
```swift
let gtfs = try GTFS(path: stringPath)
```
Where `stringPath` points to your GTFS folder.

#### GTFS-RT
```swift
let data: Data = fetchGTFSRTData()
let feedMessage = TransitRealtime_FeedMessage(serializedData: data)
```

### Design

GTFS provides simple structures for GTFS data. Notably initializing a `GTFS` object can take a long time, so this portion of the package is not recommended for on-device usable. GTFS-RT structures are provided via Apple's [Swift ProtoBuff](https://github.com/apple/swift-protobuf) package.

## Dependencies

- [swift-protobuf](https://github.com/apple/swift-protobuf), for GTFS-RT.

## Testing

Currently SwiftPM doesn't provide fixtures, so testing this package is difficult, and in progress.

## Contact

Feel free to email questions and comments to [emma@emma.sh](mailto:emma@emma.sh)

## License

GTFSis released under the MIT license. [See LICENSE](https://github.com/emma-k-alexandra/GTFS/blob/master/LICENSE) for details.
