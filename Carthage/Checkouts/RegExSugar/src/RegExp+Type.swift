import Foundation
/**
 * Closure
 */
extension RegExp {
   public typealias Replacer = (_ match: String) -> String? // if nil is returned then replacer closure didn't want to replace the match
   public typealias Replace = (_ result: NSTextCheckingResult) -> ReplacmentResult? // if nil is returned then replacer closure didn't want to replace the match
//   public typealias Matcher = (_ result: NSTextCheckingResult) -> MatcherResult // if nil is returned then replacer closure didn't want to replace the match
}
/**
 * Type
 */
extension RegExp {
   public typealias ReplacmentResult = [(range: NSRange/*Range<String.Index>*/, replacement: String)]
//   public typealias MatcherResult = (range: Range<String.Index>, match: String)
   public typealias MatchResult = (range: NSRange, match: String)
//   public typealias MatcherResults = [MatcherResult]
   public typealias MatchResults = [MatchResult]
}
