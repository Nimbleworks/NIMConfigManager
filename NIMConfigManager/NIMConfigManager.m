//
//  NIMConfigManager.m
//  config
//
//  Created by John Nye on 24/02/2014.
//  Copyright (c) 2014 Nimbleworks LLP. All rights reserved.
//

#import "NIMConfigManager.h"

static NSCache *colorCache;
static UIColor *colorWithHexString(NSString *hexString);

@interface NIMConfigManager ()

@property (nonatomic, strong) NSCache *colorCache;

@end

@implementation NIMConfigManager

@synthesize configPlist = _configPlist;
@synthesize colorCache = _colorCache;

+ (NIMConfigManager*)sharedManager;
{
    static dispatch_once_t pred;
    static NIMConfigManager *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[NIMConfigManager alloc] init];
    });
    
    return shared;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    
    NSString *selStr = NSStringFromSelector(sel);

    if([selStr rangeOfString:@":"].location == NSNotFound){
        objc_property_t property = class_getProperty([NIMConfigManager class], [selStr UTF8String]);
        
        const char * value = property_getTypeString( property );
        NSLog(@"%s", value);

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
        
        if(strcmp(value, "T@\"UIColor\"")==0) {
            return class_addMethod(self, sel, (IMP)DynamicDictionaryGetterUIColor, @encode(id(*)(id, SEL)));
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

static NSArray* DynamicDictionaryGetterNSArray(id self, SEL _cmd){
    return [[self configPlist] objectForKey:NSStringFromSelector(_cmd)];
}

static UIColor* DynamicDictionaryGetterUIColor(id self, SEL _cmd){
    NSString *key = NSStringFromSelector(_cmd);
    
    if (colorCache == nil){
        colorCache = [[NSCache alloc] init];
    }
    
    UIColor *cacheColor = [colorCache objectForKey:key];
    if (cacheColor != nil) {
        return cacheColor;
    }
    
    NSString *colorString = [[self configPlist] objectForKey:key];
    UIColor *color = colorWithHexString(colorString);
    if (color != nil) {
        [colorCache setObject:color forKey:key];
        return color;
    }
    return [UIColor blackColor];
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



static UIColor *colorWithHexString(NSString *hexString) {
    
    /**
    *
    *Taken from DB5 by Brent Simmons https://github.com/quartermaster/DB5/blob/master/Source/VSTheme.m
    *
    **/

    /*Picky. Crashes by design.*/
	
	if (hexString == nil || [hexString length]==0)
		return [UIColor blackColor];
    
	NSMutableString *s = [hexString mutableCopy];
	[s replaceOccurrencesOfString:@"#" withString:@"" options:0 range:NSMakeRange(0, [hexString length])];
	CFStringTrimWhitespace((__bridge CFMutableStringRef)s);
    
	NSString *redString = [s substringToIndex:2];
	NSString *greenString = [s substringWithRange:NSMakeRange(2, 2)];
	NSString *blueString = [s substringWithRange:NSMakeRange(4, 2)];
    
	unsigned int red = 0, green = 0, blue = 0;
	[[NSScanner scannerWithString:redString] scanHexInt:&red];
	[[NSScanner scannerWithString:greenString] scanHexInt:&green];
	[[NSScanner scannerWithString:blueString] scanHexInt:&blue];
    
	return [UIColor colorWithRed:(CGFloat)red/255.0f green:(CGFloat)green/255.0f blue:(CGFloat)blue/255.0f alpha:1.0f];

}

@end
