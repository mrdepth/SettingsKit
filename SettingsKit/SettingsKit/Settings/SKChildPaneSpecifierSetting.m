//
//  SKChildPaneSpecifierSetting.m
//  SettingsKit
//
//  Created by mr_depth on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKChildPaneSpecifierSetting.h"
#import "SKViewController.h"

@interface SKChildPaneSpecifierSetting()
@property (nonatomic, readwrite, retain) NSString* file;
@end

@implementation SKChildPaneSpecifierSetting
@synthesize file;
@synthesize shouldPerformAction;

- (id) initWithDictionary:(NSDictionary*) dictionary viewController:(SKViewController*) aViewController {
	if (self = [super initWithDictionary:dictionary viewController:aViewController]) {
		self.file = [dictionary valueForKey:SKFile];
		shouldPerformAction = NSSelectorFromString([dictionary valueForKey:SKShouldPerformAction]);
	}
	return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc {
	[file release];
	[super dealloc];
}
#endif

@end
