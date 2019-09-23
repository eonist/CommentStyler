# CommentStyler

##### Converts JS-style comment blocks to Obj-c style comment blocks:

<img width="407" alt="img" src="convert.gif?raw=true">

##### Consolidate parameters:

<img width="303" alt="img" src="consolidate.gif?raw=true">

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

### Instructions:

1. select and copy the code you want to format
2. click the convert-comment-block button
3. paste the code

### Dependencies:
- [RegExSugar](https://github.com/eonist/RegExSugar)
- [ClipboardSugar](https://github.com/eonist/ClipboardSugar)

### Todo:

- Figure out how to get the keyboard hi-jacking code to work in modern macOS apps ✅
- Cleanup and refactor
- Add bulk feature (select folder and convert all .swift files)
- Add cmd + alt + cmd + 8 command to activate convert call
