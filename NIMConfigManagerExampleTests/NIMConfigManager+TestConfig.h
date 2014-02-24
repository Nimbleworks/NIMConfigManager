//
//  NIMConfigManager+TestConfig.h
//  NIMConfigManagerExample
//
//  Created by John Nye on 24/02/2014.
//  Copyright (c) 2014 Nimbleworks LLP. All rights reserved.
//

#import "NIMConfigManager.h"

@interface NIMConfigManager (TestConfig)


@property(readonly)NSString* string;
@property(readonly)BOOL boolean;
@property(readonly)NSNumber* number;
@property(readonly)NSData* data;
@property(readonly)NSDate* date;
@property(readonly)NSArray* array;

@end
