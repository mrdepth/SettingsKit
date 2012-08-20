//
//  SKToggleSwitchSpecifierSetting.m
//  SettingsKit
//
//  Created by mr_depth on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKToggleSwitchSpecifierSetting.h"
#import "SKViewController.h"

@interface SKToggleSwitchSpecifierSetting()
@property(nonatomic, readwrite, retain) NSObject* trueValue;
@property(nonatomic, readwrite, retain) NSObject* falseValue;

@end

@implementation SKToggleSwitchSpecifierSetting
@synthesize trueValue;
@synthesize falseValue;

- (id) initWithDictionary:(NSDictionary*) dictionary viewController:(SKViewController*) aViewController {
	if (self = [super initWithDictionary:dictionary viewController:aViewController]) {
		self.trueValue = [dictionary valueForKey:SKTrueValue];
		self.falseValue = [dictionary valueForKey:SKFalseValue];
		if (!self.trueValue)
			self.trueValue = @(YES);
		if (!self.falseValue)
			self.falseValue = @(NO);
	}
	return self;
}

- (void) dealloc {
	[trueValue release];
	[falseValue release];
	[super dealloc];
}
@end
