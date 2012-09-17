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
@property (nonatomic, readwrite, retain) NSString* image;
@property (nonatomic, readwrite, assign) SKRadioGroupSpecifierSetting* radioGroup;
@end

@implementation SKRadioGroupValueSpecifierSetting
@synthesize value;
@synthesize radioGroup;
@synthesize image;

- (id) initWithRadioGroup:(SKRadioGroupSpecifierSetting*) aRadioGroup value:(NSObject*) aValue title:(NSString*) aTitle image:(NSString*) aImage viewController:(SKViewController *)viewController {
	if (self = [super initWithViewController:viewController]) {
		self.value = aValue;
		self.title = aTitle;
		self.radioGroup = aRadioGroup;
		self.image = aImage;
	}
	return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc {
	[value release];
	[super dealloc];
}
#endif

@end
