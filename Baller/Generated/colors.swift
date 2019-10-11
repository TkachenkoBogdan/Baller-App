// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#11090c"></span>
  /// Alpha: 100% <br/> (0x11090cff)
  internal static let animatedBackgroundDark1 = ColorName(rgbaValue: 0x11090cff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#212121"></span>
  /// Alpha: 100% <br/> (0x212121ff)
  internal static let animatedBackgroundDark2 = ColorName(rgbaValue: 0x212121ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#424242"></span>
  /// Alpha: 100% <br/> (0x424242ff)
  internal static let animatedBackgroundDark3 = ColorName(rgbaValue: 0x424242ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#b4ffff"></span>
  /// Alpha: 100% <br/> (0xb4ffffff)
  internal static let animatedBackgroundLight1 = ColorName(rgbaValue: 0xb4ffffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#73fbd5"></span>
  /// Alpha: 100% <br/> (0x73fbd5ff)
  internal static let animatedBackgroundLight2 = ColorName(rgbaValue: 0x73fbd5ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#6684ff"></span>
  /// Alpha: 100% <br/> (0x6684ffff)
  internal static let animatedBackgroundLight3 = ColorName(rgbaValue: 0x6684ffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ff2d55"></span>
  /// Alpha: 100% <br/> (0xff2d55ff)
  internal static let customRed = ColorName(rgbaValue: 0xff2d55ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#fc0072"></span>
  /// Alpha: 100% <br/> (0xfc0072ff)
  internal static let indigo = ColorName(rgbaValue: 0xfc0072ff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

// swiftlint:disable operator_usage_whitespace
internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
