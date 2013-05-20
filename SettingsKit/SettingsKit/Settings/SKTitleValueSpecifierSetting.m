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
		NSString* accessoryTypeString = [dictionary valueForKey:SKAccessoryType];
		if ([accessoryTypeString isEqualToString:@"Checkmark"])
			accessoryType = UITableViewCellAccessoryCheckmark;
		else if ([accessoryTypeString isEqualToString:@"DetailDisclosureButton"])
			accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
		else if ([accessoryTypeString isEqualToString:@"DisclosureIndicator"])
			accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		else
			accessoryType = UITableViewCellAccessoryNone;
		
		self.accessoryImage = [dictionary valueForKey:SKAccessoryImage];
	}
	return self;
}

@end
