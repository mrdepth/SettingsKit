//
//  SKDestructiveButtonSetting.m
//  SettingsKit
//
//  Created by Artem Shimanski on 11.10.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKDestructiveButtonSetting.h"
#import "SKViewController.h"

@interface SKDestructiveButtonSetting()
@end

@implementation SKDestructiveButtonSetting
@synthesize action;

- (id) initWithDictionary:(NSDictionary*) dictionary viewController:(SKViewController*) aViewController {
	if (self = [super initWithDictionary:dictionary viewController:aViewController]) {
		action = NSSelectorFromString([dictionary valueForKey:SKAction]);
	}
	return self;
}

@end
