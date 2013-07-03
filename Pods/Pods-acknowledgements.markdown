# Acknowledgements
This application makes use of the following third party libraries:

## AALaunchTransition

Copyright (c) 2012 Ahmet AYGÜN

Permission is hereby granted, free of charge, to any person obtaining
 a copy of this software and associated documentation files (the "Software"),
 to deal in the Software without restriction, including without limitation
 the rights to use, copy, modify, merge, publish, distribute, sublicense,
 and/or sell copies of the Software, and to permit persons to whom
 the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## AFNetworking

Copyright (c) 2011 Gowalla (http://gowalla.com/)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


## AKSegmentedControl

Copyright (c) 2013 Ali Karagoz (http://alikaragoz.net/)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

## ALRadial

ALRadial
========
ALRadial is meant to replicate the radial menu's found in the path ios app. a central button is used to display many others eminating out in a circle.

the effect looks best with round icons.

social icons from the veo design somacro set:
http://veodesign.com/2011/en/11/08/somacro-27-free-big-and-simple-social-media-icons/

video of the control:
http://www.youtube.com/watch?v=9uszKz4Ct8U

Use
---
to use it in your project just copy the ALRadial directory, and implement the delegate methods.
the delegates for this control try to match up closesly with uitableview whenever possible.

documentation for this control is on github, or build and install it locally with the documentation build target (appledoc required)

ARC is used in the control, the example project requires ARC and autolayout

Author
------
http://github.com/alattis

http://andrewlattis.com

License (MIT)
-------------
Copyright (c) 2012 Andrew Lattis

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


## AMAttributedHighlightLabel

Copyright (c) 2013 Alexander Meiler

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


## CocoaLumberjack

Software License Agreement (BSD License)

Copyright (c) 2010, Deusty, LLC
All rights reserved.

Redistribution and use of this software in source and binary forms,
with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above
  copyright notice, this list of conditions and the
  following disclaimer.

* Neither the name of Deusty nor the names of its
  contributors may be used to endorse or promote products
  derived from this software without specific prior
  written permission of Deusty, LLC.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

## DRKonamiCode

Do no evil.


## GoogleAnalytics-iOS-SDK

Copyright 2009 - 2012 Google, Inc. All rights reserved.


## JASidePanels

JASidePanels
===

JASidePanels is a UIViewController container designed for presenting a center panel with revealable side panels - one to the left and one to the right.  The main inspiration for this project is the menuing system in Path 2.0 and Facebook's iOS apps.

Demo
---
![iPhone Example](https://img.skitch.com/20120322-dx6k69577ra37wwgqgmsgksqpx.jpg)
![iPad Example](https://img.skitch.com/20120322-ttu951nfb8cpd5ti5r1ni8428y.jpg)

Example 1: Code
---

```  objc

#import "JAAppDelegate.h"

#import "JASidePanelController.h"
#import "JACenterViewController.h"
#import "JALeftViewController.h"
#import "JARightViewController.h"

@implementation JAAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	self.viewController = [[JASidePanelController alloc] init];
	self.viewController.leftPanel = [[JALeftViewController alloc] init];
	self.viewController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[JACenterViewController alloc] init]];
	self.viewController.rightPanel = [[JARightViewController alloc] init];
	
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end

```

Example 2: Storyboards
---

1. Create a subclass of `JASidePanelController`. In this example we call it `MySidePanelController`.
2. In the Storyboard designate the root view's owner as `MySidePanelController`.
3. Make sure to `#import "JASidePanelController.h"` in `MySidePanelController.h`.
4. Add more view controllers to your Storyboard, and give them identifiers "leftViewController", "centerViewController" and "rightViewController". Note that in the new XCode the identifier is called "Storyboard ID" and can be found in the Identity inspector (in older versions the identifier is found in the Attributes inspector).
5. Add a method `awakeFromNib` to `MySidePanelController.m` with the following code:

```  objc

-(void) awakeFromNib
{
  [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"leftViewController"]];
  [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"centerViewController"]];
  [self setRightPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"rightViewController"]];
}

```

Usage
---

Only two files are required for using JASidePanels: ` JASidePanelController.h ` & ` JASidePanelController.m `

The easiest way to use JASidePanels is to copy the files into your XCode Project.

Alternatively, you can setup a git submodule and reference the files in your Xcode project. I prefer this method as it enables you to receive bugfixes/updates for the project.
` git submodule add https://github.com/gotosleep/JASidePanels.git JASidePanels `

Make sure to include the QuartzCore framework in your target.

UIViewController+JASidePanel Category
---

A UIViewController+JASidePanel category is included in the project. Usage is optional. The category adds a single convenience property to UIViewController: __sidePanelController__. The property provides access to the nearest JASidePanelController ancestor in your view controller heirarchy. It behaves similar to the _navigationController_ UIViewController property provided by Apple. Here's an example:

``` objc

#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"

@interface JALeftViewController : UIViewController
@end

@implementation JALeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // sweet, I can access my parent JASidePanelController as a property!
    [self.sidePanelController showCenterPanelAnimated:YES];
}

@end

```

Requirements
---

JASidePanels requires iOS 5.0+ and Xcode 4.3+ The projects uses ARC, but it may be used with non-ARC projects by setting the: ` -fobjc-arc ` compiler flag on ` JASidePanelController.m `. You can set this flag under Target -> Build Phases -> Compile Sources

Apps
---
JASidePanels is used in the following apps:

* Scribd - [http://itunes.apple.com/us/app/scribd-worlds-largest-online/id542557212?ls=1&mt=8](http://itunes.apple.com/us/app/scribd-worlds-largest-online/id542557212?ls=1&mt=8)
* Float Reader - [http://itunes.apple.com/us/app/float-reader/id447992005?ls=1&mt=8](http://itunes.apple.com/us/app/float-reader/id447992005?ls=1&mt=8)

License
---

```

 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 If you happen to meet one of the copyright holders in a bar you are obligated
 to buy them one pint of beer.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
 ```

Alternatives
---
Other projects implementing a similar UI

* DDMenuController - [https://github.com/devindoty/DDMenuController](https://github.com/devindoty/DDMenuController)
* JTRevealSidebarDemo - [https://github.com/mystcolor/JTRevealSidebarDemo](https://github.com/mystcolor/JTRevealSidebarDemo)
* ECSlidingViewController - [https://github.com/edgecase/ECSlidingViewController](https://github.com/edgecase/ECSlidingViewController)
* ViewDeck - [https://github.com/Inferis/ViewDeck](https://github.com/Inferis/ViewDeck)
* ZUUIRevealController - [https://github.com/pkluz/ZUUIRevealController](https://github.com/pkluz/ZUUIRevealController)
* GHSidebarNav - [https://github.com/gresrun/GHSidebarNav](https://github.com/gresrun/GHSidebarNav)


## MJPopupViewController

Copyright (c) 2012 Martin Juhasz

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.


## NewRelicAgent

----------------------------------------------------------------

This product includes 'Apple Reachability' (http://developer.apple.com/library/ios/#samplecode/Reachability/Introduction/Intro.html), which is released under the following license(s):
    Apple Reachability <http://developer.apple.com/library/ios/#samplecode/Reachability/Listings/Classes_Reachability_m.html>

----------------------------------------------------------------

This product includes 'Base64' (https://github.com/nicklockwood/Base64), which is released under the following license(s):
    Charcoal Design Base64 <https://github.com/nicklockwood/Base64/blob/master/LICENCE.md>

----------------------------------------------------------------

This product includes 'SecureUDID' (http://www.secureudid.org/), which is released under the following license(s):
    MIT <http://opensource.org/licenses/mit-license.html>

----------------------------------------------------------------

All other components of this product are: Copyright (c) 2010-2013 New Relic, Inc. All rights reserved.

Certain inventions disclosed in this file may be claimed within patents owned or patent applications
filed by New Relic, Inc. or third parties. Subject to the terms of this notice, New Relic grants you
a nonexclusive, nontransferable license, without the right to sublicense, to (a) install and execute
one copy of these files on any number of workstations owned or controlled by you and (b) distribute
verbatim copies of these files to third parties. As a condition to the foregoing grant, you must
provide this notice along with each copy you distribute and you must not remove, alter, or obscure
this notice.

All other use, reproduction, modification, distribution, or other exploitation of these
files is strictly prohibited, except as may be set forth in a separate written license agreement
between you and New Relic. The terms of any such license agreement will control over this notice. The
license stated above will be automatically terminated and revoked if you exceed its scope or violate
any of the terms of this notice.

This License does not grant permission to use the trade names, trademarks, service marks, or product
names of New Relic, except as required for reasonable and customary use in describing the origin of
this file and reproducing the content of this notice. You may not mark or brand this file with any
trade name, trademarks, service marks, or product names other than the original brand (if any) provided
by New Relic.

Unless otherwise expressly agreed by New Relic in a separate written license agreement, these files
are provided AS IS, WITHOUT WARRANTY OF ANY KIND, including without any implied warranties of
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE, or NON-INFRINGEMENT. As a condition to your
use of these files, you are solely responsible for such use. New Relic will have no liability to you
for direct, indirect, consequential, incidental, special, or punitive damages or for lost profits or
data.


## OHAttributedLabel

/***********************************************************************************
 * This software is under the MIT License quoted below:
 ***********************************************************************************
 *
 * Copyright (c) 2010 Olivier Halligon
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 ***********************************************************************************/

## SIAlertView

Copyright (c) 2013 Sumi Interactive

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## TestFlightLogger

The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## TestFlightSDK

All text and design is copyright © 2010-2013 TestFlight App, Inc.

All rights reserved.

https://testflightapp.com/tos/

Generated by CocoaPods - http://cocoapods.org
