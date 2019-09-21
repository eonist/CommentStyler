# ArraySugar
Sugar for array

### How do I get it
- Carthage `github "eonist/ArraySugar"`
- Manual Open `.xcodeproj`
- CocoaPod (Coming soon)

## Examples:
**BinaryIndex**

```swift
let key = 11
var numbers = [9, 15, 91]
let idx = binaryIndex(numbers, key, 0, numbers.count) // 1
if idx >= numbers.count || numbers[idx] != key { numbers.insert(key, at: idx) }
print(numbers) // [9, 11, 15, 91]
```

**BinarySearch**
```swift
let numbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]
binarySearch(numbers, key: 43, range: 0 ..< numbers.count) // output: 13 which is the index of where the key is
```

**RecursiveFlatmap**
```swift
let arr: [Any] = [[[1], [2, 3]], [[4, 5], [6]]] // 👈 3d array (3 depths deep)
let x2: [Int] = arr.recursiveFlatmap()
Swift.print(x2)//[1,2,3,4,5,6]
```

**Scale array**
```swift
Swift.print(scaleArr(arr: [0, 1, 1, 0], size: (width: 2, height: 2), scale:2))// [0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0]
Swift.print(scaleArr(arr: [0, 0, 0, 1, 0, 1, 0, 0, 0], size: (width: 3, height: 3), scale: 2)) // [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
```

### Todo:
- Clean up comments
- Add UnitTest
- Add CI
