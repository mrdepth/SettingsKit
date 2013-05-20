//
//  SKSetting.m
//  SettingsKit
//
//  Created by Artem Shimanski on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKSetting.h"
#import "SKViewController.h"
#import "SKTitleValueSpecifierSetting.h"
#import "SKTextFieldSpecifierSetting.h"
#import "SKToggleSwitchSpecifierSetting.h"
#import "SKSliderSpecifierSetting.h"
#import "SKMultiValueSpecifierSetting.h"
#import "SKChildPaneSpecifierSetting.h"
#import "SKGroupSpecifierSetting.h"
#import "SKRadioGroupSpecifierSetting.h"
#import "SKSegmentedSpecifierSetting.h"
#import "SKDestructiveButtonSetting.h"

@interface SKSetting()
@property (nonatomic, readwrite, assign) SKViewController* viewController;
@property (nonatomic, readwrite, retain) NSString* title;
@property (nonatomic, readwrite, retain) NSString* image;
@property (nonatomic, readwrite, assign) UITextAlignment textAlignment;
@property (nonatomic, readwrite, assign) UITableViewCellStyle cellStyle;
@property (nonatomic, readwrite, retain) NSString* onlyDisplayOnInterfaceIdiom;
@property (nonatomic, retain) NSString* titleKeyPath;
@property (nonatomic, retain) NSPredicate* predicate;
@property (nonatomic) SEL conditionSelector;
@property (nonatomic, getter = isNegativeCondition) BOOL negativeCondition;
@property (nonatomic) BOOL displayOnCurrentInterfaceIdiom;
@end

@implementation SKSetting
@synthesize viewController;
@synthesize title;
@synthesize image;
@synthesize titleKeyPath;
@synthesize onlyDisplayOnInterfaceIdiom;
@synthesize predicate;
@synthesize conditionSelector;
@synthesize negativeCondition;

+ (id) settingWithDictionary:(NSDictionary*) dictionary viewController:(SKViewController*) viewController {
	NSString* type = [dictionary valueForKey:SKType];
	SKSetting* setting = nil;
	if ([type isEqualToString:SKPSTitleValueSpecifier])
		setting = [[SKTitleValueSpecifierSetting alloc] initWithDictionary:dictionary viewController:viewController];
	else if ([type isEqualToString:SKPSTextFieldSpecifier])
		setting = [[SKTextFieldSpecifierSetting alloc] initWithDictionary:dictionary viewController:viewController];
	else if ([type isEqualToString:SKPSToggleSwitchSpecifier])
		setting = [[SKToggleSwitchSpecifierSetting alloc] initWithDictionary:dictionary viewController:viewController];
	else if ([type isEqualToString:SKPSSliderSpecifier])
		setting = [[SKSliderSpecifierSetting alloc] initWithDictionary:dictionary viewController:viewController];
	else if ([type isEqualToString:SKPSMultiValueSpecifier])
		setting = [[SKMultiValueSpecifierSetting alloc] initWithDictionary:dictionary viewController:viewController];
	else if ([type isEqualToString:SKPSChildPaneSpecifier])
		setting = [[SKChildPaneSpecifierSetting alloc] initWithDictionary:dictionary viewController:viewController];
	else if ([type isEqualToString:SKPSGroupSpecifier])
		setting = [[SKGroupSpecifierSetting alloc] initWithDictionary:dictionary viewController:viewController];
	else if ([type isEqualToString:SKPSRadioGroupSpecifier])
		setting = [[SKRadioGroupSpecifierSetting alloc] initWithDictionary:dictionary viewController:viewController];
	else if ([type isEqualToString:SKSegmentedSpecifier])
		setting = [[SKSegmentedSpecifierSetting alloc] initWithDictionary:dictionary viewController:viewController];
	else if ([type isEqualToString:SKDestructiveButtonSpecifier])
		setting = [[SKDestructiveButtonSetting alloc] initWithDictionary:dictionary viewController:viewController];
#if ! __has_feature(objc_arc)
	[setting autorelease];
#endif
	return setting;
}

- (id) initWithDictionary:(NSDictionary*) dictionary viewController:(SKViewController*) aViewController {
	if (self = [super init]) {
		self.viewController = aViewController;
		
		self.title = [dictionary valueForKey:SKTitle];
		self.titleKeyPath = [dictionary valueForKey:SKTitleKeyPath];
		if (self.title)
			self.title = NSLocalizedStringFromTableInBundle(self.title, self.viewController.stringsTable, self.viewController.bundle, nil);
		self.image = [dictionary valueForKey:SKImage];
		
		NSString* textAlignmentString = [dictionary valueForKey:SKTextAlignment];
		if ([textAlignmentString isEqualToString:@"UITextAlignmentCenter"])
			self.textAlignment = UITextAlignmentCenter;
		else if ([textAlignmentString isEqualToString:@"UITextAlignmentRight"])
			self.textAlignment = UITextAlignmentRight;
		else
			self.textAlignment = UITextAlignmentLeft;

		NSString* cellStyleString = [dictionary valueForKey:SKCellStyle];
		if ([cellStyleString isEqualToString:@"UITableViewCellStyleDefault"])
			self.cellStyle = UITableViewCellStyleDefault;
		else if ([textAlignmentString isEqualToString:@"UITableViewCellStyleValue2"])
			self.cellStyle = UITableViewCellStyleValue2;
		else if ([textAlignmentString isEqualToString:@"UITableViewCellStyleSubtitle"])
			self.cellStyle = UITableViewCellStyleSubtitle;
		else
			self.cellStyle = UITableViewCellStyleValue1;

		self.displayOnCurrentInterfaceIdiom = YES;
		self.onlyDisplayOnInterfaceIdiom = [dictionary valueForKey:SKOnlyDisplayOnInterfaceIdiom];
		if (self.onlyDisplayOnInterfaceIdiom) {
			BOOL iPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
			if ((iPad && [self.onlyDisplayOnInterfaceIdiom isEqualToString:@"Phone"]) || (!iPad && [self.onlyDisplayOnInterfaceIdiom isEqualToString:@"Pad"]))
				self.displayOnCurrentInterfaceIdiom = NO;
		}
		
		NSString* predicateString = [dictionary valueForKey:SKPredicate];
		if (predicateString) {
			self.predicate = [NSPredicate predicateWithFormat:predicateString];
		}
		
		NSString* conditionSelectorString = [dictionary valueForKey:SKConditionSelector];
		if (conditionSelectorString) {
			if (conditionSelectorString.length > 0 && [conditionSelectorString characterAtIndex:0] == '!') {
				conditionSelectorString = [conditionSelectorString substringFromIndex:1];
				self.negativeCondition = YES;
			}
			else
				self.negativeCondition = NO;

			self.conditionSelector = NSSelectorFromString(conditionSelectorString);
		}
		
		[self update];
	}
	return self;
}

- (id) initWithViewController:(SKViewController*) aViewController {
	if (self = [super init]) {
		self.viewController = aViewController;
		self.displayOnCurrentInterfaceIdiom = YES;
	}
	return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc {
	[title release];
	[image release];
	[onlyDisplayOnInterfaceIdiom release];
	[titleKeyPath release];
	[predicate release];
	[super dealloc];
}
#endif

- (BOOL) isHidden {
	if (!self.displayOnCurrentInterfaceIdiom)
		return YES;
	else if (self.predicate)
		return ![self.predicate evaluateWithObject:self.viewController.settingsObject];
	else if (self.conditionSelector) {
		NSMethodSignature* signature = [self.viewController methodSignatureForSelector:self.conditionSelector];
		NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
		[invocation setSelector:self.conditionSelector];
		[invocation setTarget:self.viewController];
		[invocation invoke];
		BOOL result = YES;
		[invocation getReturnValue:&result];
		return self.negativeCondition ? result : !result;
	}
	else
		return NO;
}

- (void) update {
	if (self.titleKeyPath)
		self.title = [self.viewController valueForKey:self.titleKeyPath];
}

@end
