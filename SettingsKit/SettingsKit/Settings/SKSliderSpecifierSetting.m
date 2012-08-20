//
//  SKSliderSpecifierSetting.m
//  SettingsKit
//
//  Created by mr_depth on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKSliderSpecifierSetting.h"
#import "SKViewController.h"

@interface SKSliderSpecifierSetting()
@property (nonatomic, readwrite, retain) NSNumber* minimumValue;
@property (nonatomic, readwrite, retain) NSNumber* maximumValue;
@property (nonatomic, readwrite, retain) NSString* minimumValueImage;
@property (nonatomic, readwrite, retain) NSString* maximumValueImage;
@end

@implementation SKSliderSpecifierSetting
@synthesize minimumValue;
@synthesize maximumValue;
@synthesize minimumValueImage;
@synthesize maximumValueImage;

- (id) initWithDictionary:(NSDictionary*) dictionary viewController:(SKViewController*) aViewController {
	if (self = [super initWithDictionary:dictionary viewController:aViewController]) {
		self.minimumValue = [dictionary valueForKey:SKMinimumValue];
		self.maximumValue = [dictionary valueForKey:SKMaximumValue];
		self.minimumValueImage = [dictionary valueForKey:SKMinimumValueImage];
		self.maximumValueImage = [dictionary valueForKey:SKMaximumValueImage];
		if (!self.minimumValue)
			self.minimumValue = @(0.0);
		if (!self.maximumValue)
			self.maximumValue = @([self.minimumValue floatValue] + 1.0);
	}
	return self;
}

- (void) dealloc {
	[minimumValue release];
	[maximumValue release];
	[minimumValueImage release];
	[maximumValueImage release];
	[super dealloc];
}

@end
