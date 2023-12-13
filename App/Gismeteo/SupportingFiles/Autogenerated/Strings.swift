// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable all

internal enum L10n {

  internal enum Api {
    /// appid
    internal static let appid = L10n.tr("Localizable", "API.appid")
    /// CitiesData.plist
    internal static let citiesData = L10n.tr("Localizable", "API.citiesData")
    /// q
    internal static let city = L10n.tr("Localizable", "API.city")
    /// exclude
    internal static let exclude = L10n.tr("Localizable", "API.exclude")
    /// lat
    internal static let lat = L10n.tr("Localizable", "API.lat")
    /// lon
    internal static let lon = L10n.tr("Localizable", "API.lon")
    /// metric
    internal static let metric = L10n.tr("Localizable", "API.metric")
    /// minutely
    internal static let minutely = L10n.tr("Localizable", "API.minutely")
    /// /onecall
    internal static let path = L10n.tr("Localizable", "API.path")
    /// /weather
    internal static let pathCity = L10n.tr("Localizable", "API.pathCity")
    /// units
    internal static let units = L10n.tr("Localizable", "API.units")
  }

  internal enum Cell {
    /// dailyTableView
    internal static let dailyTableView = L10n.tr("Localizable", "Cell.dailyTableView")
    /// findTableView
    internal static let findTableView = L10n.tr("Localizable", "Cell.findTableView")
    /// hourlyCollectionView
    internal static let hourlyCollectionView = L10n.tr("Localizable", "Cell.hourlyCollectionView")
    /// hourlyTableView
    internal static let hourlyTableView = L10n.tr("Localizable", "Cell.hourlyTableView")
  }

  internal enum DateFormat {
    /// EEEE
    internal static let day = L10n.tr("Localizable", "DateFormat.day")
    /// HH
    internal static let hour = L10n.tr("Localizable", "DateFormat.hour")
    /// HH:mm
    internal static let time = L10n.tr("Localizable", "DateFormat.time")
  }

  internal enum Downloaded {
    /// image
    internal static let image = L10n.tr("Localizable", "Downloaded.image")
    /// 200
    internal static let statusCode = L10n.tr("Localizable", "Downloaded.statusCode")
  }

  internal enum FatalError {
    /// Unable to dequeue Cell
    internal static let cell = L10n.tr("Localizable", "FatalError.cell")
    /// init(coder:) has not been implemented
    internal static let `required` = L10n.tr("Localizable", "FatalError.required")
  }

  internal enum StringS {
    /// 
    internal static let empty = L10n.tr("Localizable", "StringS.empty")
    /// Error
    internal static let error = L10n.tr("Localizable", "StringS.error")
    /// %%.f
    internal static let format = L10n.tr("Localizable", "StringS.format")
    /// max: 
    internal static let max = L10n.tr("Localizable", "StringS.max")
    /// min: 
    internal static let min = L10n.tr("Localizable", "StringS.min")
    /// now
    internal static let now = L10n.tr("Localizable", "StringS.now")
    /// Ok
    internal static let ok = L10n.tr("Localizable", "StringS.ok")
    /// Search for a city or airport
    internal static let placeholder = L10n.tr("Localizable", "StringS.placeholder")
    /// /
    internal static let `prefix` = L10n.tr("Localizable", "StringS.prefix")
    /// _
    internal static let replacing = L10n.tr("Localizable", "StringS.replacing")
    /// °
    internal static let scale = L10n.tr("Localizable", "StringS.scale")
    /// °,
    internal static let scalePlus = L10n.tr("Localizable", "StringS.scalePlus")
    ///  
    internal static let space = L10n.tr("Localizable", "StringS.space")
    /// Sunrise
    internal static let sunrise = L10n.tr("Localizable", "StringS.sunrise")
    /// Sunset
    internal static let sunset = L10n.tr("Localizable", "StringS.sunset")
  }

  internal enum SystemImage {
    /// list.bullet
    internal static let list = L10n.tr("Localizable", "SystemImage.list")
    /// location.fill
    internal static let location = L10n.tr("Localizable", "SystemImage.location")
    /// magnifyingglass
    internal static let magnifyingglass = L10n.tr("Localizable", "SystemImage.magnifyingglass")
    /// multiply
    internal static let multiply = L10n.tr("Localizable", "SystemImage.multiply")
    /// plus
    internal static let plus = L10n.tr("Localizable", "SystemImage.plus")
    /// trash
    internal static let trash = L10n.tr("Localizable", "SystemImage.trash")
  }

  internal enum WeatherAPI {
    /// api.openweathermap.org
    internal static let host = L10n.tr("Localizable", "WeatherAPI.host")
    /// http://openweathermap.org/img/wn/
    internal static let hostImage = L10n.tr("Localizable", "WeatherAPI.hostImage")
    /// @2x.png
    internal static let image = L10n.tr("Localizable", "WeatherAPI.image")
    /// 289d79262f138bd6ebb226285fd277e3
    internal static let key = L10n.tr("Localizable", "WeatherAPI.key")
    /// /data/2.5
    internal static let path = L10n.tr("Localizable", "WeatherAPI.path")
    /// http
    internal static let scheme = L10n.tr("Localizable", "WeatherAPI.scheme")
    /// http://openweathermap.org/img/wn/
    internal static let urlString = L10n.tr("Localizable", "WeatherAPI.urlString")
  }
}

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
// swiftlint:enable all