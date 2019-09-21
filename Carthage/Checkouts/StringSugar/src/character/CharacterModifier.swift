public class CharacterModifier {
    /**
     * Removes a character at PARAM: index
     * - NOTE: These can be used to remove first and last: str.removeAtIndex(str.characters.indices.first!) // remove first letterstr.removeAtIndex(str.characters.indices.last!) // remove last letter
     */
    public static func removeAt(_ str:inout String, _ index: Int) -> String {
        let idx = str.index(str.startIndex, offsetBy: index)//upgraded to swift 3-> was: startIndex.advancedBy
        str.remove(at: idx)
        return str
    }
    /**
     * Removes last letter
     */
    public static func removeFirst(_ str:inout String) -> String {
        str.remove(at: str.string.indices.first!)
        return str
    }
    /**
     * Removes last letter
     */
    public static func removeLast(_ str:inout String) -> String {
        str.remove(at: str.string.indices.last!)
        return str
    }
}
