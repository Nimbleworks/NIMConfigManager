//
//  NIMConfigManager.m
//  config
//
//  Created by John Nye on 24/02/2014.
//  Copyright (c) 2014 Nimbleworks LLP. All rights reserved.
//

#import "NIMConfigManager.h"

@implementation NIMConfigManager

@synthesize configPlist = _configPlist;

+ (NIMConfigManager*)sharedManager;
{
    static dispatch_once_t pred;
    static NIMConfigManager *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[NIMConfigManager alloc] init];
    });
    
    return shared;
}

-(id)init{
    return [super init];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    
    NSString *selStr = NSStringFromSelector(sel);

    if([selStr rangeOfString:@":"].location == NSNotFound){
        objc_property_t property = class_getProperty([NIMConfigManager class], [selStr UTF8String]);
        
        const char * value = property_getTypeString( property );

        if (strcmp(value, "Tc") == 0 || strcmp(value, "TB")==0){
            return class_addMethod(self, sel, (IMP)DynamicDictionaryGetterBool, @encode(id(*)(id, SEL)));
        }
        
        if(strcmp(value, "Tf") == 0){
            return class_addMethod(self, sel, (IMP)DynamicDictionaryGetterFloat, @encode(id(*)(id, SEL)));
        }
        
        if (strcmp(value, "T@\"NSString\"")==0) {
            return class_addMethod(self, sel, (IMP)DynamicDictionaryGetterNSString, @encode(id(*)(id, SEL)));
        }
        
        if (strcmp(value, "T@\"NSNumber\"")==0){
            return class_addMethod(self, sel, (IMP)DynamicDictionaryGetterNSNumber, @encode(id(*)(id, SEL)));
        }
        if(strcmp(value, "T@\"NSDate\"")==0){
            return class_addMethod(self, sel, (IMP)DynamicDictionaryGetterNSDate, @encode(id(*)(id, SEL)));
        }
        if(strcmp(value, "T@\"NSData\"")==0){
            return class_addMethod(self, sel, (IMP)DynamicDictionaryGetterNSData, @encode(id(*)(id, SEL)));
        }
        if(strcmp(value, "T@\"NSArray\"")==0){
            return class_addMethod(self, sel, (IMP)DynamicDictionaryGetterNSArray, @encode(id(*)(id, SEL)));
        }

    }
    return [super resolveInstanceMethod:sel];
}

static BOOL DynamicDictionaryGetterBool(id self, SEL _cmd){
    return [[[self configPlist] objectForKey:NSStringFromSelector(_cmd)]boolValue];
}

static float DynamicDictionaryGetterFloat(id self, SEL _cmd){
    return [[[self configPlist] objectForKey:NSStringFromSelector(_cmd)]floatValue];
}

static NSString* DynamicDictionaryGetterNSString(id self, SEL _cmd){
    return [[self configPlist] objectForKey:NSStringFromSelector(_cmd)];
}

static NSNumber* DynamicDictionaryGetterNSNumber(id self, SEL _cmd){
    return [[self configPlist] objectForKey:NSStringFromSelector(_cmd)];
}

static NSDate* DynamicDictionaryGetterNSDate(id self, SEL _cmd){
    return [[self configPlist] objectForKey:NSStringFromSelector(_cmd)];
}

static NSData* DynamicDictionaryGetterNSData(id self, SEL _cmd){
    return [[self configPlist] objectForKey:NSStringFromSelector(_cmd)];
}

static NSData* DynamicDictionaryGetterNSArray(id self, SEL _cmd){
    return [[self configPlist] objectForKey:NSStringFromSelector(_cmd)];
}

const char* property_getTypeString (objc_property_t property){
    const char * attrs = property_getAttributes( property );
    
    if (attrs == NULL){
        return (NULL);
    }
    
    static char buffer[256];
    const char * e = strchr( attrs, ',');
    
    if (e == NULL){
        return NULL;
    }
    
    int len = (int)(e - attrs);
    memcpy(buffer, attrs, len);
    buffer[len] = '\0';
    return buffer;
}

@end
