# SwiftyGestureRecognition

A drop-in library for extending UIGestureRecognizers to aid in prototyping with them in Xcode Playgrounds. 

Definitely not prime for shipping I wrote it just for demo purposes, but it's fun to mess with. Use it to write less boilerplate code when trying out UIGestureRecognizers in Xcode Playgrounds.

Was built for my presentation at [try! Swift 2016](http://www.tryswift.com), so be sure to check out my talk when it's posted! :D

Example includes a playground that shows logging a UIPanGestureRecognizer.

### How do I use it?

Create an Xcode Workspace with a playground. Drag + drop SwiftyGestureRecognition.xcodeproj into the workspace and import it into your playground: `import SwiftyGestureRecognition`.

Using UIGestureRecognizers is now pretty simple!

```swift
let gestureRecognizer = UIPanGestureRecognizer(view: aView)
  .didBegin { (gestureRecognizer) in
    print("began")
  }.didChange { (gestureRecognizer) in
    print("changed")
  }.didEnd { (gestureRecognizer) in
    print("ended")
}
```

### How do I compile?
Xcode pretty much.

### License?
Pretty much the BSD license, just don't repackage it and call it your own please!

Also if you do make some changes, feel free to make a pull request and help make things more awesome!

### Contact Info?

Feel free to follow me on twitter: [@b3ll](https://www.twitter.com/b3ll)!
