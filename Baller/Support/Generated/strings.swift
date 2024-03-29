// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// No default answers
  internal static let noDefaultAnswers = L10n.tr("Localizable", "noDefaultAnswers")

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
    /// Failed finding expected path: 
    internal static let failedToFindPath = L10n.tr("Localizable", "FatalErrors.failedToFindPath")
    /// Object must not be initialized from xib/storyboard
    internal static let initCoder = L10n.tr("Localizable", "FatalErrors.init(coder:)")
    /// Failed to provide local answer
    internal static let noLocalAnswer = L10n.tr("Localizable", "FatalErrors.noLocalAnswer")
    internal enum Realm {
      /// Failed to add the answer to the Realm!
      internal static let failedToAddAnswer = L10n.tr("Localizable", "FatalErrors.realm.failedToAddAnswer")
      /// Failed to delete all answers from the Realm
      internal static let failedToDeleteAllAnswers = L10n.tr("Localizable", "FatalErrors.realm.failedToDeleteAllAnswers")
      /// Failed to delete the answer from the Realm!
      internal static let failedToDeleteAnswer = L10n.tr("Localizable", "FatalErrors.realm.failedToDeleteAnswer")
      /// Failed to initialize Realm
      internal static let failedToInitialize = L10n.tr("Localizable", "FatalErrors.realm.failedToInitialize")
    }
  }

  internal enum Filenames {
    internal enum Realm {
      /// bundledAnswers.realm
      internal static let bundled = L10n.tr("Localizable", "Filenames.realm.bundled")
      /// mainAnswers.realm
      internal static let main = L10n.tr("Localizable", "Filenames.realm.main")
    }
  }

  internal enum Labels {
    /// Shake
    internal static let statusLabel = L10n.tr("Localizable", "Labels.statusLabel")
  }

  internal enum Migration {
    /// Migration from 0 to version 1
    internal static let from0to1 = L10n.tr("Localizable", "Migration.from0to1")
    /// Migration from 1 to version 2
    internal static let from1to2 = L10n.tr("Localizable", "Migration.from1to2")
    /// Migration from 2 to version 3
    internal static let from2to3 = L10n.tr("Localizable", "Migration.from2to3")
    /// Migration from 3 to version 4
    internal static let from3to4 = L10n.tr("Localizable", "Migration.from3to4")
    /// Migration from 4 to version 5
    internal static let from4to5 = L10n.tr("Localizable", "Migration.from4to5")
  }

  internal enum Prompts {
    /// Provide an answer
    internal static let newAnswer = L10n.tr("Localizable", "Prompts.newAnswer")
    internal enum DeleteAll {
      /// Are you sure that you want to delete all answers?
      internal static let message = L10n.tr("Localizable", "Prompts.deleteAll.message")
      /// Delete All
      internal static let title = L10n.tr("Localizable", "Prompts.deleteAll.title")
    }
  }

  internal enum SectionHeader {
    /// History
    internal static let history = L10n.tr("Localizable", "SectionHeader.History")
  }

  internal enum Titles {
    /// 
    internal static let answerHistory = L10n.tr("Localizable", "Titles.AnswerHistory")
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
