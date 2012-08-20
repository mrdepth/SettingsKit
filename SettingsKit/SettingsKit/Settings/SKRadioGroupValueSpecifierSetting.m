//
//  SKRadioGroupValueSpecifierSetting.m
//  SettingsKit
//
//  Created by mr_depth on 18.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKRadioGroupValueSpecifierSetting.h"

@interface SKRadioGroupValueSpecifierSetting()
@property (nonatomic, readwrite, retain) NSObject* value;
@property (nonatomic, readwrite, retain) NSString* title;
@property (nonatomic, readwrite, retain) SKRadioGroupSpecifierSetting* radioGroup;
@end

@implementation SKRadioGroupValueSpecifierSetting
@synthesize value;
@synthesize radioGroup;

- (id) initWithRadioGroup:(SKRadioGroupSpecifierSetting*) aRadioGroup value:(NSObject*) aValue title:(NSString*) aTitle viewController:(SKViewController *)viewController {
	if (self = [super initWithViewController:viewController]) {
		self.value = aValue;
		self.title = aTitle;
		self.radioGroup = aRadioGroup;
	}
	return self;
}

- (void) dealloc {
	[value release];
	[radioGroup release];
	[super dealloc];
}

@end
