//
//  SKTitleValueSpecifierSetting.m
//  SettingsKit
//
//  Created by Artem Shimanski on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKTitleValueSpecifierSetting.h"
#import "SKViewController.h"

@implementation SKTitleValueSpecifierSetting
@synthesize action;
@synthesize accessoryType;

- (id) initWithDictionary:(NSDictionary*) dictionary viewController:(SKViewController*) aViewController {
	if (self = [super initWithDictionary:dictionary viewController:aViewController]) {
		action = NSSelectorFromString([dictionary valueForKey:SKAction]);
		
	}
	return self;
}

@end
