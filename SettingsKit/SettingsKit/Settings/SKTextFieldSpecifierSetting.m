//
//  SKTextFieldSpecifierSetting.m
//  SettingsKit
//
//  Created by mr_depth on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKTextFieldSpecifierSetting.h"
#import "SKViewController.h"

@interface SKTextFieldSpecifierSetting()
@property (nonatomic, readwrite, retain) NSString* placeholder;
@end

@implementation SKTextFieldSpecifierSetting
@synthesize secureTextEntry;
@synthesize keyboardType;
@synthesize autocapitalizationType;
@synthesize autocorrectionType;

- (id) initWithDictionary:(NSDictionary*) dictionary viewController:(SKViewController*) aViewController {
	if (self = [super initWithDictionary:dictionary viewController:aViewController]) {
		secureTextEntry = [[dictionary valueForKey:SKIsSecure] boolValue];
		
		NSString* keyboardTypeString = [dictionary valueForKey:SKKeyboardType];
		if ([keyboardTypeString isEqualToString:@"NumbersAndPunctuation"])
			keyboardType = UIKeyboardTypeNumbersAndPunctuation;
		else if ([keyboardTypeString isEqualToString:@"NumberPad"])
			keyboardType = UIKeyboardTypeNumberPad;
		else if ([keyboardTypeString isEqualToString:@"URL"])
			keyboardType = UIKeyboardTypeURL;
		else if ([keyboardTypeString isEqualToString:@"EmailAddress"])
			keyboardType = UIKeyboardTypeEmailAddress;
		else
			keyboardType = UIKeyboardTypeAlphabet;
		
		NSString* autocapitalizationTypeString = [dictionary valueForKey:SKAutocapitalizationType];
		if ([autocapitalizationTypeString isEqualToString:@"Sentences"])
			autocapitalizationType = UITextAutocapitalizationTypeSentences;
		else if ([autocapitalizationTypeString isEqualToString:@"Words"])
			autocapitalizationType = UITextAutocapitalizationTypeWords;
		else if ([autocapitalizationTypeString isEqualToString:@"AllCharacters"])
			autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
		else
			autocapitalizationType = UITextAutocapitalizationTypeNone;
		
		NSString* autocorrectionTypeString = [dictionary valueForKey:SKAutocorrectionType];
		if ([autocorrectionTypeString isEqualToString:@"No"])
			autocorrectionType = UITextAutocorrectionTypeNo;
		else if ([autocorrectionTypeString isEqualToString:@"Yes"])
			autocorrectionType = UITextAutocorrectionTypeYes;
		else
			autocorrectionType = UITextAutocorrectionTypeDefault;
		
		self.placeholder = [dictionary valueForKey:SKPlaceholder];
	}
	return self;
}

@end
