# NIMConfigManager

[![Version](http://cocoapod-badges.herokuapp.com/v/NIMConfigManager/badge.png)](http://cocoadocs.org/docsets/NIMConfigManager)
[![Platform](http://cocoapod-badges.herokuapp.com/p/NIMConfigManager/badge.png)](http://cocoadocs.org/docsets/NIMConfigManager)

## Usage

To use create a category of NIMConfigManager, such as `NIMConfigManager+myApp`. We create dynamic acessors for each of the properties in your config.plist. For an example look at `NIMConfigManager+Example.m` and `exampleConfig.plist`.

If your config plist contains in the following: 

````
	<key>labelText</key>
	<string>Hello World!</string>
	<key>hideBigButton</key>
	<true/>
````

Our `NIMConfigManager+myApp.h` would look like: 

````
	@interface NIMConfigManager (myApp)

	@property(readonly)NSString* labelText;
	@property(readonly)BOOL hideBigButton;

	@end
````

And the `NIMConfigManager+myApp.m` would be: 
````
	@implementation NIMConfigManager (myApp)

	@dynamic labelText;
	@dynamic hideBigButton;

	@end
````

Usage is pretty simple, we include the category and initialise the sharedManager, after pass it our `config.plist` file. 

````
	NIMConfigManager *manager = [NIMConfigManager sharedManager];
	manager.configPlist = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                                      pathForResource:@"config"
                                                                      ofType:@"plist"]];

````

Accessing any of the properties we need is as simple as: 

````
	manager.labelText;
````

#### Important Notes
Currently this manager supports all native plist types, __excluding__ NSDictionaries.

## Requirements
NIMConfigManager has no external requirements. 

## Installation

NIMConfigManager is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "NIMConfigManager"

## Credits
Big thanks to [Amy Worrall](http://www.amyworrall.com) for her talk at iOSConfUK. All of the clever code in this has been ripped studiously from her presentation slides. 

## Author

John Nye, [@john_nye](https://twitter.com/john_nye)

## License

NIMConfigManager is available under the MIT license. See the LICENSE file for more info.

