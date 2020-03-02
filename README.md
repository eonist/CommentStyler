# CommentStyler

##### Converts JS-style comment blocks to Obj-c style comment blocks:

<img width="407" alt="img" src="convert.gif?raw=true">


### Example:

```swift
/**
 * Comment
 */

 To:

 ///
 /// Comment
 ///
```

##### Consolidate parameters:

<img width="303" alt="img" src="consolidate.gif?raw=true">


### Example:

```swift
/**
 * A method that creates circles
 * - Parameter color: the color of the circle
 * - Parameter radius: the radius of the circle
 * - Parameter pivot: the center point of the citcle
 */

 To:

/**
 * A method that creates circles
 * - Parameters:
 *   - color: the color of the circle
 *   - radius: the radius of the circle
 *   - pivot: the center point of the citcle
 */
```
### Instructions:

1. Select and copy the code you want to format
2. Click the convert-comment-block button
3. Paste the code

### Dependencies:
- [RegExSugar](https://github.com/eonist/RegExSugar)
- [ClipboardSugar](https://github.com/eonist/ClipboardSugar)

### Todo:

- Figure out how to get the keyboard hi-jacking code to work in modern macOS apps ✅
- Cleanup and refactor
- Add bulk feature (select folder and convert all .swift files)
- Add cmd + alt + cmd + 8 command to activate convert call
