//
//  SKKeyValueSetting.m
//  SettingsKit
//
//  Created by Artem Shimanski on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKKeyValueSetting.h"
#import "SKViewController.h"

@interface SKKeyValueSetting()
@property (nonatomic, readwrite, retain) NSString* key;
@property (nonatomic, readwrite, retain) NSObject* defaultValue;
@property (nonatomic, retain) NSString* defaultValueKeyPath;
@property (nonatomic, retain) NSString* valueKeyPath;
@end

@implementation SKKeyValueSetting
@synthesize key;
@synthesize defaultValue;
@synthesize shouldChangeValueSelector;
@synthesize didChangeValueSelector;

@synthesize defaultValueKeyPath;
@synthesize valueKeyPath;

- (id) initWithDictionary:(NSDictionary*) dictionary viewController:(SKViewController*) aViewController {
	if (self = [super initWithDictionary:dictionary viewController:aViewController]) {
		self.key = [dictionary valueForKey:SKKey];
		self.defaultValue = [dictionary valueForKey:SKDefaultValue];
		self.defaultValueKeyPath = [dictionary valueForKey:SKDefaultValueKeyPath];
		self.valueKeyPath = [dictionary valueForKey:SKValueKeyPath];
		//shouldChangeValueSelector = NSSelectorFromString([dictionary valueForKey:SKShouldChangeValue]);
		//didChangeValueSelector = NSSelectorFromString([dictionary valueForKey:SKShouldChangeValue]);
		if (self.key.length > 0) {
			NSMutableString* keyPart = [NSMutableString stringWithString:self.key];
			[keyPart replaceCharactersInRange:NSMakeRange(0, 1) withString:[[keyPart substringToIndex:1] uppercaseString]];
			shouldChangeValueSelector = NSSelectorFromString([NSString stringWithFormat:@"shouldChange%@WithValue:", keyPart]);
			didChangeValueSelector = NSSelectorFromString([NSString stringWithFormat:@"didChange%@WithValue:", keyPart]);
		}
		
		NSObject* value = nil;
		if (self.key) {
			value = [self.viewController.settingsObject valueForKey:self.key];
		
			if (!value) {
				value = self.value;
				if (value)
					[self.viewController.settingsObject setValue:value forKey:self.key];
			}
		}
	}
	return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc {
	[key release];
	[defaultValue release];
	[defaultValueKeyPath release];
	[valueKeyPath release];
	
	[super dealloc];
}
#endif

- (NSObject*) value {
	NSObject* value = nil;
	if (self.key)
		value = [self.viewController.settingsObject valueForKey:self.key];
	
	if (!value)
		value = self.defaultValue;
	if (!value && self.defaultValueKeyPath)
		value = [self.viewController.settingsObject valueForKey:self.defaultValueKeyPath];
	
	if (!value && self.valueKeyPath)
		value = [self.viewController valueForKey:self.valueKeyPath];
	return value;
}

- (void) setValue:(NSObject *)value {
	if (self.key)
		[self.viewController.settingsObject setValue:value forKey:self.key];
}

@end
