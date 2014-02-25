//
//  NIMConfigManager+Example.m
//
//
//  Created by John Nye on 25/02/2014.
//  Copyright (c) 2014 Nimbleworks LLP. All rights reserved.
//

#import "NIMConfigManager.h"

@interface NIMConfigManager (Example)

@property(readonly)NSString* facebookAppID;
@property(readonly)NSString* googleAnalyticsID;
@property(readonly)BOOL activateMegaNewFeature;

@end

@implementation NIMConfigManager (Example)

@dynamic facebookAppID;
@dynamic googleAnalyticsID;
@dynamic activateMegaNewFeature;

@end


