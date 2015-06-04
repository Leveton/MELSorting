MELSorting
=======

Sort UIViews with UIPanGestureRecognizer.  Receive delegate notifications for the positions of moved views and swapped views.  Useful for games, pickers, settings, and menus.
            
<img src="https://raw.github.com/Leveton/MELSorting/master/screenshots/screenshot.png" alt="TSNavigationStripView examples" width="320" height="568" />

## Requirements

* Xcode 4.5 or higher
* Apple LLVM compiler

## Setup

See this [tutorial](http://leveton.blogspot.com/2013/08/using-custom-sorting-control-to-demo.html) for an explanation of how I put it together and what I use it for.

Drag the 'MELSortingView' folder into your project.  Make sure 'Copy items if needed' and 'Create groups' is checked.

Add the object to your view controller specifying the x and y offsets, the width, and the number of sortable views that you need.  You can also add numbered labels.  To stay in tune with Apple's [Human Interface Guidelines,](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/MobileHIG/) the view must be at least 100px wide.

``` objc
MELSortingView *sortView = [MELSortingView sortingViewWithViews:6 XOffset:0 YOffset:0 andWidth:self.view.frame.size.width];
sortView.delegate = self;
[sortView addLabels];
[self.view addSubview:sortView];
```

Receive delegate notifications whenever a view is moved or two views have swapped places.  These methods tell you the positions of the moving views from 0..n.

``` objc
- (void)view:(MELSortingView *)sortingView wasMovedWithView:(UIView *)aView
- (void)view:(MELSortingView *)sortingView didAlternateView:(UIView *)departureView withView:(UIView *)destinationView
```    

## Contact

- Mike Leveton
- mleveton@prepcloud.com

## License

MELSorting is available under the MIT license.

Copyright © 2015 Mike Leveton

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.