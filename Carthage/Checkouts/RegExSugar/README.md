# RegExSugar

- Makes parsing and modifying with RegEx easier  

```swift
"My name is Taylor Swift".match("My name is Taylor (.*)")//Swift
"yeah yeah".replace("(\\b\\w+\\b)", "bla")//bla bla
"hello world".test("o.*o")//true
/*RegExp Exec:*/
let str = "blue:0000FF green:00FF00 red:FF0000"
RegExp.matches(str, "(\\w+?)\\:([A-Z0-9]+?)(?: |$)").forEach {
    Swift.print("match.numberOfRanges: " + "\($0.numberOfRanges)")/*The first item is the entire match*/
    let content = (str as NSString).substringWithRange($0.rangeAtIndex(0))/*the entire match*/
    let name = $0.value(str, 1)/*capturing group 1*/
    let value = $0.value(str, 2)/*capturing group 2*/
}//Outputs: name: green, value: 00FF00...and so on
```

### Another example: 

```swift
let str = "Serial: #YF 1942-b 12/01/17 (Scanned) 12/03/17 (Arrived) ref: 99/99/99"
let usDatePattern:String = "(\\d\\d)[-\\/](\\d\\d)[-\\/](\\d\\d(?:\\d\\d)?)"//Must be in the format: 12-30-1968 (mm-dd-yyyy) works with: "12-30-1968" and "12/30/1968" syntax
let matches = str.matches(usDatePattern)//RegExpMatch.datePattern
matches.forEach {
    let month:String = $0.value(str, 1)
    let day:String = $0.value(str, 2)
    let year:String = $0.value(str, 3)
    let dateStr:String = year + "/" + month + "/" + day
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yy/mm/dd"
    let date:Date? = dateFormatter.date(from: dateStr)
    if date != nil {Swift.print(dateStr)}//Output: 17/12/01, 17/12/03
}
```

The above was actually a challenge with [mathewsanders](https://github.com/mathewsanders)  [Mustard](https://github.com/mathewsanders/Mustard) : [Challenge](https://github.com/mathewsanders/Mustard/issues/8) 
