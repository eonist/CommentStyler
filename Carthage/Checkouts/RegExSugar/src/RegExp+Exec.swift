import Foundation

extension RegExp {
   /**
    * Coming soon
    */
   public static func exec() {
      //Fixme: ⚠️️ research enumerateMatches, it takes a method and enumerate all matches.
      //NSRegularExpression.replacementString has an offset, which I think you can use
   }
}


//    static func replaceMatches<T: Sequence>(in source:String, matches:T, using replacer:(Match) -> String?) -> String where T.Iterator.Element : Match {
//
//        "str".matches("(\\w+?)\\:([A-Z0-9]+?)(?: |$)").forEach {
//            Swift.print("match.numberOfRanges: " + "\($0.numberOfRanges)")/*The first item is the entire match*/
//            let content = (str as NSString).substringWithRange($0.rangeAtIndex(0))/*the entire match*/
//            let name = $0.value("", 1)/*capturing group 1*/
//
//            (str as NSString).substring(with: result.rangeAt(key))
//
//        }
//
//        var result = ""
//        var lastRange:StringRange = source.startIndex ..< source.startIndex
//        for match in matches {
//            result += source.substring(with: lastRange.upperBound ..< match.range.lowerBound)
//            if let replacement = replacer(match) {
//                result += replacement
//            } else {
//                result += source.substring(with: match.range)
//            }
//            lastRange = match.range
//        }
//        result += source.substring(from: lastRange.upperBound)
//        return result
//    }
//
//
/**
 Replaces all occurances of the pattern using supplied replacer function.
 
 - Parametereters:
 - source: String to be matched to the pattern
 - replacer: Function that takes a match and returns a replacement. If replacement is nil, the original match gets inserted instead
 - returns: A string, where all the occurances of the pattern were replaced
 */
//    static func replaceAll(_ source:String,  replacer:(Match) -> String?) -> String {
//        let matches = findAll(in: source)
//        return replaceMatches(in: source, matches: matches, using: replacer)
//    }
