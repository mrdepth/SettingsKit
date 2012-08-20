//
//  SKGroupSpecifierSetting.m
//  SettingsKit
//
//  Created by mr_depth on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKGroupSpecifierSetting.h"
#import "SKViewController.h"

@interface SKGroupSpecifierSetting()
@property (nonatomic, readwrite, retain) NSString* footerText;
@property (nonatomic, readwrite, retain) NSMutableArray* settings;
@property (nonatomic, retain) NSString* footerTextKeyPath;
@end

@implementation SKGroupSpecifierSetting
@synthesize footerText;
@synthesize settings;
@synthesize footerTextKeyPath;

- (id) initWithDictionary:(NSDictionary*) dictionary viewController:(SKViewController*) aViewController {
	if (self = [super initWithDictionary:dictionary viewController:aViewController]) {
		self.footerText = [dictionary valueForKey:SKFooterText];
		self.footerTextKeyPath = [dictionary valueForKey:SKFooterTextKeyPath];
		if (!self.footerText && self.footerTextKeyPath)
			self.footerText = [self.viewController valueForKey:self.footerTextKeyPath];
		
		if (self.footerText)
			self.footerText = NSLocalizedStringFromTableInBundle(self.footerText, self.viewController.stringsTable, self.viewController.bundle, nil);

		self.settings = [NSMutableArray array];
	}
	return self;
}

- (void) dealloc {
	[footerText release];
	[settings release];
	[footerTextKeyPath release];
	[super dealloc];
}

@end