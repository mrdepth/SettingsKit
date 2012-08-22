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

		self.settings = [NSMutableArray array];
		int n = self.values.count;
		for (int i = 0; i < n; i++) {
			[self.settings addObject:[[[SKRadioGroupValueSpecifierSetting alloc] initWithRadioGroup:self value:[self.values objectAtIndex:i] title:[self.titles objectAtIndex:i] viewController:self.viewController] autorelease]];
		}
	}
	return self;
}

- (void) dealloc {
	[footerText release];
	[settings release];
	[footerTextKeyPath release];
	[super dealloc];
}

- (NSString*) footerText {
	if (footerText)
		return footerText;
	else if (self.footerTextKeyPath)
		return [self.viewController valueForKey:self.footerTextKeyPath];
	else
		return nil;
}

@end
