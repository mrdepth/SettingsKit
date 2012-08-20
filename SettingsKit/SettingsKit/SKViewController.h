//
//  SKViewController.h
//  SettingsKit
//
//  Created by Artem Shimanski on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import <UIKit/UIKit.h>

//Buildin settings
#define SKPreferenceSpecifiers @"PreferenceSpecifiers"
#define SKStringsTable @"StringsTable"
#define SKPSTextFieldSpecifier @"PSTextFieldSpecifier"
#define SKPSTitleValueSpecifier @"PSTitleValueSpecifier"
#define SKPSToggleSwitchSpecifier @"PSToggleSwitchSpecifier"
#define SKPSSliderSpecifier @"PSSliderSpecifier"
#define SKPSMultiValueSpecifier @"PSMultiValueSpecifier"
#define SKPSRadioGroupSpecifier @"PSRadioGroupSpecifier"
#define SKPSGroupSpecifier @"PSGroupSpecifier"
#define SKPSChildPaneSpecifier @"PSChildPaneSpecifier"

#define SKType @"Type"
#define SKTitle @"Title"
#define SKFooterText @"FooterText"
#define SKOnlyDisplayOnInterfaceIdiom @"OnlyDisplayOnInterfaceIdiom"
#define SKFile @"File"
#define SKKey @"Key"
#define SKDefaultValue @"DefaultValue"
#define SKTrueValue @"TrueValue"
#define SKFalseValue @"FalseValue"
#define SKMinimumValue @"MinimumValue"
#define SKMaximumValue @"MaximumValue"
#define SKMinimumValueImage @"MinimumValueImage"
#define SKMaximumValueImage @"MaximumValueImage"
#define SKValues @"Values"
#define SKTitles @"Titles"
#define SKIsSecure @"IsSecure"
#define SKKeyboardType @"KeyboardType"
#define SKAutocapitalizationType @"AutocapitalizationType"
#define SKAutocorrectionType @"AutocorrectionType"
#define SKShortTitles @"ShortTitles"


//Controller settings
#define SKNibName @"NibName"
#define SKClassName @"ClassName"

//New Specifiers
#define SKSegmentedSpecifier @"SegmentedSpecifier"

//Items general settings
#define SKPredicate @"Predicate"
#define SKConditionSelector @"ConditionSelector"
#define SKDefaultValueKeyPath @"DefaultValueKeyPath"
#define SKValuesKeyPath @"ValuesKeyPath"
#define SKTitlesKeyPath @"TitlesKeyPath"
#define SKShortTitlesKeyPath @"ShortTitlesKeyPath"
#define SKTitleKeyPath @"TitleKeyPath"
#define SKFooterTextKeyPath @"FooterTextKeyPath"
#define SKValueKeyPath @"ValueKeyPath"
#define SKAccessoryType @"AccessoryType"
#define SKShouldChangeValue @"ShouldChangeValue"
#define SKDidChangeValue @"DidChangeValue"
#define SKAction @"Action"
#define SKShouldPerformAction @"ShouldPerformAction"

#define SKGroupKey @"SKGroupKey"
#define SKVisibleRowsKey @"SKVisibleRowsKey"


@class SKSetting;
@interface SKViewController : UITableViewController
@property (nonatomic, readonly, retain) NSObject* settingsObject;
@property (nonatomic, readonly, retain) NSString* stringsTable;
@property (nonatomic, readonly, retain) NSBundle* bundle;

+ (id) viewControllerWithPreferences:(NSDictionary*) preferences bundle:(NSBundle*) bundle settingsObject:(NSObject*) settingsObject;
+ (id) viewControllerWithContentsOfFile:(NSString*) fileName bundle:(NSBundle*) bundle settingsObject:(NSObject*) settingsObject;

- (void) updateAnimated:(BOOL) animated;
- (NSIndexPath*) indexPathForSetting:(SKSetting*) setting;

@end
