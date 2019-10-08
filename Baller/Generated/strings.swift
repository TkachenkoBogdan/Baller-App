// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// numberOfShakeAttmepts
  internal static let numberOfShakeAttempts = L10n.tr("Localizable", "numberOfShakeAttempts")

  internal enum AnswerType {
    /// Affirmative
    internal static let affirmative = L10n.tr("Localizable", "AnswerType.affirmative")
    /// Countrary
    internal static let countrary = L10n.tr("Localizable", "AnswerType.countrary")
    /// Neutral
    internal static let neutral = L10n.tr("Localizable", "AnswerType.neutral")
  }

  internal enum BarItemTitles {
    /// 8Ball
    internal static let _8ball = L10n.tr("Localizable", "BarItemTitles._8ball")
    /// History
    internal static let history = L10n.tr("Localizable", "BarItemTitles.history")
  }

  internal enum FatalErrors {
    /// Could not dequeue cell with identifier: 
    internal static let cannotDequeCell = L10n.tr("Localizable", "FatalErrors.cannotDequeCell")
    /// Object must not be initialized from xib/storyboard
    internal static let initCoder = L10n.tr("Localizable", "FatalErrors.init(coder:)")
    /// Failed to provide local answer
    internal static let noLocalAnswer = L10n.tr("Localizable", "FatalErrors.noLocalAnswer")
  }

  internal enum Filenames {
    /// answers.json
    internal static let answerFile = L10n.tr("Localizable", "Filenames.answerFile")
    /// defaultAnswers.txt
    internal static let defaultAnswers = L10n.tr("Localizable", "Filenames.defaultAnswers")
  }

  internal enum Labels {
    /// Shake
    internal static let statusLabel = L10n.tr("Localizable", "Labels.statusLabel")
  }

  internal enum Prompts {
    /// Click on + to add an answer
    internal static let additionInfo = L10n.tr("Localizable", "Prompts.additionInfo")
    /// Provide an answer
    internal static let newAnswer = L10n.tr("Localizable", "Prompts.newAnswer")
  }

  internal enum Titles {
    /// Defaults
    internal static let answerList = L10n.tr("Localizable", "Titles.AnswerList")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
