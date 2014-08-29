//
//  NIMConfigManagerExampleTests.m
//  NIMConfigManagerExampleTests
//
//  Created by John Nye on 24/02/2014.
//  Copyright (c) 2014 Nimbleworks LLP. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NIMConfigManager+TestConfig.h"

@interface NIMConfigManagerExampleTests : XCTestCase{
    NIMConfigManager *manager;
}

@end

@implementation NIMConfigManagerExampleTests

- (void)setUp
{
    [super setUp];
    manager = [NIMConfigManager sharedManager];
    manager.configPlist = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle
                                                                       bundleForClass:[self class]]
                                                                      pathForResource:@"test"
                                                                      ofType:@"plist"]];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

-(void)testString{
    XCTAssert([[NSString stringWithFormat:@"Hello"] isEqualToString:manager.string], @"Failed on strings ");
}

-(void)testNSNumber{
    XCTAssert([manager.number floatValue] == 21.0f, @"Floats are not working. ");
}

-(void)testBool{
    XCTAssertTrue(manager.boolean == YES, @"Bools not working ");
}

-(void)testArray{    
    XCTAssertTrue(manager.array.count == 3, @"Arrays are broken");
}

-(void)testData{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:@"VGhpcyBpcyBEYXRh" options:NSDataBase64DecodingIgnoreUnknownCharacters];
    XCTAssertTrue([data isEqualToData:manager.data], @"Data is causing problems");
}

-(void)testDate{
    NSString *str =@"2001-04-29 20:53:00 +0000";
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    
    NSDate *d = [formatter dateFromString:str];
    
    NSLog(@"%@ :: %@ \n %@", [manager.date description], [d description], str);
    XCTAssertTrue([d isEqualToDate:manager.date], @"Dates are not working");
}

-(void)testColor{
    UIColor *aColor = [UIColor colorWithRed:0.471 green:0.471 blue:0.990 alpha:1.000];
    if (![aColor isEqual:manager.color]) {
        NSLog(@"%@", manager.color);
        NSLog(@"%@", aColor);
        XCTFail(@"Colours Don't Match");
    }
}


@end