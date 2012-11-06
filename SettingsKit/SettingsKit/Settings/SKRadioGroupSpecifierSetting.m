//
//  SKRadioGroupSpecifierSetting.m
//  SettingsKit
//
//  Created by mr_depth on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKRadioGroupSpecifierSetting.h"
#import "SKRadioGroupValueSpecifierSetting.h"
#import "SKViewController.h"

@interface SKRadioGroupSpecifierSetting()
@property (nonatomic, readwrite, retain) NSString* footerText;
@property (nonatomic, readwrite, retain) NSMutableArray* settings;
@property (nonatomic, retain) NSString* footerTextKeyPath;
@end

@implementation SKRadioGroupSpecifierSetting
@synthesize footerText;
@synthesize settings;
@synthesize footerTextKeyPath;

- (id) initWithDictionary:(NSDictionary*) dictionary viewController:(SKViewController*) aViewController {
	if (self = [super initWithDictionary:dictionary viewController:aViewController]) {
		self.footerText = [dictionary valueForKey:SKFooterText];
		self.footerTextKeyPath = [dictionary valueForKey:SKFooterTextKeyPath];
		
		if (footerText)
			self.footerText = NSLocalizedStringFromTableInBundle(footerText, self.viewController.stringsTable, self.viewController.bundle, nil);
	}
	return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc {
	[footerText release];
	[settings release];
	[footerTextKeyPath release];
	[super dealloc];
}
#endif

- (NSString*) footerText {
	if (footerText)
		return footerText;
	else if (self.footerTextKeyPath)
		return [self.viewController valueForKey:self.footerTextKeyPath];
	else
		return nil;
}

- (void) update {
	[super update];
	self.settings = [NSMutableArray array];
	int n = self.values.count;
	for (int i = 0; i < n; i++) {
		SKRadioGroupValueSpecifierSetting* setting = [[SKRadioGroupValueSpecifierSetting alloc] initWithRadioGroup:self value:[self.values objectAtIndex:i] title:[self.titles objectAtIndex:i] image: [self.images objectAtIndex:i] viewController:self.viewController];
#if ! __has_feature(objc_arc)
		[setting autorelease];
#endif
		[self.settings addObject:setting];
	}
}

@end
