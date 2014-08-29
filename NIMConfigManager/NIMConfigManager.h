//
//  NIMConfigManager.h
//  config
//
//  Created by John Nye on 24/02/2014.
//  Copyright (c) 2014 Nimbleworks LLP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>



@interface NIMConfigManager : NSObject{
    NSDictionary* configPlist;
}

@property (retain) NSDictionary *configPlist;

+ (NIMConfigManager*)sharedManager;

@end


