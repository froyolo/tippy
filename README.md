# Pre-work - *Tippy*

**Tippy** is a tip calculator application for iOS.

Submitted by: **Naomi Ngan**

Time spent: **7** hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [x] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] Dark color theme for the settings view.
- [x] Animating view fade-in/out 

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/yx9xzZu.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Project Analysis

**Question 1**: "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:** I’ve enjoyed playing around with the development platform so far.  Within the context of the project, I would describe outlets as references to the properties of a UIView from a UIViewController, and actions are triggers detected in the UIView that cause the execution of methods in the UIViewController.  Both are ways that a view and controller can communicate with each other.

Question 2: "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:** Similar to classes, closures are reference types that allow strong references to be created.  When a closure is assigned to the property of a class instance, and the closure accesses the instance or any of its members, this creates a strong reference cycle between the instance and the closure.  In the cycle, the class instance has a strong reference to the closure, and the closure holds a strong reference back to the instance (capture of “self”).  Neither the instance nor closure can be deallocated as long as the cycle exists.

## License

Copyright [2017] [Naomi Ngan]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
