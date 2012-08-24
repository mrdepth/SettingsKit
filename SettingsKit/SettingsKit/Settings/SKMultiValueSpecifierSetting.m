//
//  SKMultiValueSpecifierSetting.m
//  SettingsKit
//
//  Created by mr_depth on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKMultiValueSpecifierSetting.h"
#import "SKViewController.h"

@interface SKMultiValueSpecifierSetting()
@property (nonatomic, readwrite, retain) NSArray* shortTitles;
@property (nonatomic, retain) NSString* shortTitlesKeyPath;
@end

@implementation SKMultiValueSpecifierSetting
@synthesize shortTitles;
@synthesize shortTitlesKeyPath;

- (id) initWithDictionary:(NSDictionary*) dictionary viewController:(SKViewController*) aViewController {
	if (self = [super initWithDictionary:dictionary viewController:aViewController]) {
		self.shortTitles = [dictionary valueForKey:SKShortTitles];
		self.shortTitlesKeyPath = [dictionary valueForKey:SKShortTitlesKeyPath];
		
		if (!self.shortTitles && self.shortTitlesKeyPath)
			self.shortTitles = [self.viewController valueForKey:self.shortTitlesKeyPath];
	}
	return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc {
	[shortTitles release];
	[shortTitlesKeyPath release];
	[super dealloc];
}
#endif

- (NSString*) valueShortTitle {
	if (self.values && self.shortTitles && self.value) {
		NSInteger index = [self.shortTitles indexOfObject:self.value];
		if (index != NSNotFound)
			return [self.shortTitles objectAtIndex:index];
	}
	return self.valueTitle;
}

@end
