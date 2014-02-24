//
//  NIMViewController.m
//  NIMConfigManagerExample
//
//  Created by John Nye on 24/02/2014.
//  Copyright (c) 2014 Nimbleworks LLP. All rights reserved.
//

#import "NIMViewController.h"
#import "NIMConfigManager+ConfigManager.h"
@interface NIMViewController ()

@end

@implementation NIMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NIMConfigManager *manager = [NIMConfigManager sharedManager];
    manager.configPlist = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"]];
    label.text = manager.labelText;
    [bigButton setHidden:manager.hideBigButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
