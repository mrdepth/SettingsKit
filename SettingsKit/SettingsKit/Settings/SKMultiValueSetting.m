//
//  SKMultiValueSetting.m
//  SettingsKit
//
//  Created by Artem Shimanski on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKMultiValueSetting.h"
#import "SKViewController.h"

@interface SKMultiValueSetting()
@property (nonatomic, readwrite, retain) NSArray* values;
@property (nonatomic, readwrite, retain) NSArray* titles;
@property(nonatomic, retain) NSString* valuesKeyPath;
@property(nonatomic, retain) NSString* titlesKeyPath;

@end


@implementation SKMultiValueSetting
@synthesize values;
@synthesize titles;
@synthesize valuesKeyPath;
@synthesize titlesKeyPath;

- (id) initWithDictionary:(NSDictionary*) dictionary viewController:(SKViewController*) aViewController {
	if (self = [super initWithDictionary:dictionary viewController:aViewController]) {
		self.values = [dictionary valueForKey:SKValues];
		NSMutableArray* titlesTmp = [dictionary valueForKey:SKTitles];
		self.valuesKeyPath = [dictionary valueForKey:SKValuesKeyPath];
		self.titlesKeyPath = [dictionary valueForKey:SKTitlesKeyPath];
		
		if (!self.values && self.valuesKeyPath)
			self.values = [self.viewController valueForKey:self.valuesKeyPath];
		

		if (!titlesTmp && self.titlesKeyPath)
			titlesTmp = [self.viewController valueForKey:self.titlesKeyPath];
		
		if (titlesTmp) {
			NSMutableArray* localizedTitles = [NSMutableArray array];
			for (NSString* string in titlesTmp) {
				[localizedTitles addObject:NSLocalizedStringFromTableInBundle(string, self.viewController.stringsTable, self.viewController.bundle, nil)];
			}
			self.titles = localizedTitles;
		}
	}
	return self;
}

- (NSString*) valueTitle {
	if (self.values && self.titles && self.value) {
		NSInteger index = [self.values indexOfObject:self.value];
		if (index != NSNotFound)
			return [self.titles objectAtIndex:index];
	}
	return nil;
}

@end