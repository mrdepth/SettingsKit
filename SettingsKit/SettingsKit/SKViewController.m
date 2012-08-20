//
//  SKViewController.m
//  SettingsKit
//
//  Created by Artem Shimanski on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKViewController.h"
#import "SKViewController.h"
#import "SKTitleValueSpecifierSetting.h"
#import "SKTextFieldSpecifierSetting.h"
#import "SKToggleSwitchSpecifierSetting.h"
#import "SKSliderSpecifierSetting.h"
#import "SKMultiValueSpecifierSetting.h"
#import "SKChildPaneSpecifierSetting.h"
#import "SKGroupSpecifierSetting.h"
#import "SKRadioGroupSpecifierSetting.h"
#import "SKRadioGroupValueSpecifierSetting.h"
#import "SKSegmentedSpecifierSetting.h"
#import "SKChildPaneCell.h"
#import "SKMultiValueCell.h"

#import "SKTitleValueCell.h"
#import "SKSegmentedCell.h"
#import "SKSliderCell.h"
#import "SKSwitchCell.h"
#import "SKTextFieldCell.h"
#import "SKRadioGroupValueCell.h"
#import "UITableViewCell+Nib.h"


@interface SKViewController ()
@property (nonatomic, readwrite, retain) NSObject* settingsObject;
@property (nonatomic, readwrite, retain) NSString* stringsTable;
@property (nonatomic, readwrite, retain) NSBundle* bundle;
@property (nonatomic, retain) NSDictionary* preferences;
@property (nonatomic, retain) NSMutableArray* sections;
@property (nonatomic, retain) NSMutableArray* visibleSections;
@property (nonatomic, retain) NSMutableDictionary* notReusableCells;

- (void) reload;
@end

@implementation SKViewController
@synthesize settingsObject;
@synthesize preferences;
@synthesize sections;
@synthesize visibleSections;
@synthesize notReusableCells;
@synthesize stringsTable;
@synthesize bundle;

+ (id) viewControllerWithPreferences:(NSDictionary*) preferences bundle:(NSBundle*) bundle settingsObject:(NSObject*) settingsObject {
	if (preferences) {
		NSString* nibName = [preferences valueForKey:SKNibName];
		NSString* className = [preferences valueForKey:SKClassName];
		Class class;
		SKViewController* controller;

		if (className)
			class = NSClassFromString(className);
		if (!className)
			class = [self class];
		if (nibName) {
			controller = [[class alloc] initWithNibName:nibName bundle:nil];
		}
		else
			controller = [[class alloc] initWithStyle:UITableViewStyleGrouped];
		controller.preferences = preferences;
		controller.settingsObject = settingsObject;
		controller.bundle = bundle;
		controller.title = [preferences valueForKey:SKTitle];
		if (!controller.title) {
			NSString* titleKeyPath = [preferences valueForKey:SKTitleKeyPath];
			if (titleKeyPath)
				controller.title = [controller valueForKey:titleKeyPath];
		}
		[controller reload];
		return [controller autorelease];
	}
	else
		return nil;
}

+ (id) viewControllerWithContentsOfFile:(NSString*) fileName bundle:(NSBundle*) bundle settingsObject:(NSObject*) settingsObject {
	NSDictionary* preferences = [NSDictionary dictionaryWithContentsOfFile:[bundle ? bundle : [NSBundle mainBundle] pathForResource:fileName ofType:@"plist"]];
	return [self viewControllerWithPreferences:preferences bundle:bundle settingsObject:settingsObject];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) dealloc {
	[settingsObject release];
	[stringsTable release];
	[bundle release];
	[preferences release];
	[sections release];
	[visibleSections release];
	[notReusableCells release];
	[super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self updateAnimated:NO];
	[self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) updateAnimated:(BOOL) animated {
	NSMutableIndexSet* sectionsToDelete = [NSMutableIndexSet indexSet];
	NSMutableIndexSet* sectionsToInsert = [NSMutableIndexSet indexSet];
	NSMutableArray* rowsToDelete = [NSMutableArray array];
	NSMutableArray* rowsToInsert = [NSMutableArray array];

	NSInteger sectionIndex = 0;
	for (NSDictionary* section in self.visibleSections) {
		SKSetting<SKGroupSetting>* group = [section valueForKey:SKGroupKey];
		if (!group.hidden) {
			NSMutableArray* visibleRows = [section valueForKey:SKVisibleRowsKey];
			NSMutableIndexSet* rowIndexesToDelete = [NSMutableIndexSet indexSet];
			NSInteger rowIndex = 0;
			
			for (SKSetting* setting in visibleRows) {
				if (setting.hidden) {
					[rowIndexesToDelete addIndex:rowIndex];
					[rowsToDelete addObject:[NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex]];
				}
				rowIndex++;
			}
			
			
			[visibleRows removeObjectsAtIndexes:rowIndexesToDelete];
		}
		else {
			[sectionsToDelete addIndex:sectionIndex];
		}
		sectionIndex++;
	}
	
	[self.visibleSections removeObjectsAtIndexes:sectionsToDelete];
	sectionIndex = 0;
	for (NSDictionary* section in self.sections) {
		if ([self.visibleSections containsObject:section]) {
			NSInteger rowIndex = 0;
			NSMutableArray* visibleRows = [section valueForKey:SKVisibleRowsKey];
			for (SKSetting* setting in  [[section valueForKey:SKGroupKey] settings]) {
				if ([visibleRows containsObject:setting])
					rowIndex++;
				else {
					if (!setting.hidden) {
						[rowsToInsert addObject:[NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex]];
						[visibleRows insertObject:setting atIndex:rowIndex];
						rowIndex++;
					}
				}
			}
			sectionIndex++;
		}
		else {
			SKSetting<SKGroupSetting>* group = [section valueForKey:SKGroupKey];
			if (!group.hidden) {
				NSMutableArray* visibleRows = [NSMutableArray array];
				for (SKSetting* setting in group.settings) {
					if (!setting.hidden)
						[visibleRows addObject:setting];
				}
				[section setValue:visibleRows forKey:SKVisibleRowsKey];
				[sectionsToInsert addIndex:sectionIndex];
				[self.visibleSections insertObject:section atIndex:sectionIndex];
				sectionIndex++;
			}
		}
	}
	if (animated) {
		[self.tableView beginUpdates];
		UITableViewRowAnimation animation = UITableViewRowAnimationFade;
		[self.tableView deleteRowsAtIndexPaths:rowsToDelete withRowAnimation:animation];
		[self.tableView deleteSections:sectionsToDelete withRowAnimation:animation];
		[self.tableView insertSections:sectionsToInsert withRowAnimation:animation];
		[self.tableView insertRowsAtIndexPaths:rowsToInsert withRowAnimation:animation];
		[self.tableView endUpdates];
	}
	else
		[self.tableView reloadData];
}

- (NSIndexPath*) indexPathForSetting:(SKSetting*) setting {
	if ([setting conformsToProtocol:@protocol(SKGroupSetting)]) {
		NSInteger sectionIndex = [self.visibleSections indexOfObject:setting];
		if (sectionIndex != NSNotFound)
			return [NSIndexPath indexPathForRow:NSNotFound inSection:sectionIndex];
	}
	else {
		NSInteger sectionIndex = 0;
		for (NSDictionary* section in self.visibleSections) {
			NSInteger rowIndex = [[section valueForKey:SKVisibleRowsKey] indexOfObject:setting];
			if (rowIndex != NSNotFound)
				return [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
			sectionIndex++;
		}
	}
	return nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.visibleSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[[self.visibleSections objectAtIndex:section] valueForKey:SKVisibleRowsKey] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary* section = [self.visibleSections objectAtIndex:indexPath.section];
	SKSetting* setting = [[section valueForKey:SKVisibleRowsKey] objectAtIndex:indexPath.row];
	NSString* cellIdentifier = nil;
	SKCell* cell = nil;
	Class cellClass = nil;
	NSString* nibName = nil;
	if ([setting isKindOfClass:[SKTitleValueSpecifierSetting class]]) {
		cellIdentifier = @"SKTitleValueCell";
		cellClass = [SKTitleValueCell class];
	}
	else if ([setting isKindOfClass:[SKSliderSpecifierSetting class]]) {
		cellIdentifier = @"SKSliderCell";
		cellClass = [SKSliderCell class];
		nibName = cellIdentifier;
	}
	else if ([setting isKindOfClass:[SKToggleSwitchSpecifierSetting class]]) {
		cellIdentifier = @"SKSwitchCell";
		cellClass = [SKSwitchCell class];
		nibName = cellIdentifier;
	}
	else if ([setting isKindOfClass:[SKChildPaneSpecifierSetting class]]) {
		cellIdentifier = @"SKChildPaneCell";
		cellClass = [SKChildPaneCell class];
	}
	else if ([setting isKindOfClass:[SKTextFieldSpecifierSetting class]]) {
		cellIdentifier = @"SKTextFieldCell";
		cellClass = [SKTextFieldCell class];
		nibName = cellIdentifier;
	}
	else if ([setting isKindOfClass:[SKRadioGroupValueSpecifierSetting class]]) {
		cellIdentifier = @"SKRadioGrouValueCell";
		cellClass = [SKRadioGroupValueCell class];
	}
	else if ([setting isKindOfClass:[SKMultiValueSpecifierSetting class]]) {
		cellIdentifier = @"SKMultiValueCell";
		cellClass = [SKMultiValueCell class];
	}
	else if ([setting isKindOfClass:[SKSegmentedSpecifierSetting class]]) {
		cellIdentifier = @"SKSegmentedCell";
		cellClass = [SKSegmentedCell class];
	}
	else {
		return nil;
	}
	
	if ([cellClass allowsReusing]) {
		cell = (SKCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
		if (!cell) {
			if (nibName)
				cell = [cellClass cellWithNibName:nibName bundle:nil reuseIdentifier:cellIdentifier];
			else
				cell = [[[cellClass alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
		}
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.setting = setting;
	}
	else {
		NSNumber* key = @(setting.hash);
		cell = [self.notReusableCells objectForKey:key];
		if (!cell) {
			if (nibName)
				cell = [cellClass cellWithNibName:nibName bundle:nil reuseIdentifier:cellIdentifier];
			else
				cell = [[[cellClass alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
			[self.notReusableCells setObject:cell forKey:key];
			cell.accessoryType = UITableViewCellAccessoryNone;
			cell.setting = setting;
		}
	}
	
	return cell;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	SKSetting<SKGroupSetting>* group = [[self.visibleSections objectAtIndex:section] valueForKey:SKGroupKey];
	return group.title;
}

- (NSString*) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	SKSetting<SKGroupSetting>* group = [[self.visibleSections objectAtIndex:section] valueForKey:SKGroupKey];
	return group.footerText;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Private


- (void) reload {
	if (!self.bundle)
		self.bundle = [NSBundle mainBundle];
	self.title = [self.preferences valueForKey:SKTitle];
	self.stringsTable = [self.preferences valueForKey:SKStringsTable];

	self.sections = [NSMutableArray array];
	self.visibleSections = [NSMutableArray array];
	self.notReusableCells = [NSMutableDictionary dictionary];
	SKSetting<SKGroupSetting>* currentGroup = nil;
	for (NSDictionary* record in [self.preferences valueForKey:SKPreferenceSpecifiers]) {
		SKSetting* setting = [SKSetting settingWithDictionary:record viewController:self];
		if (setting) {
			if ([setting conformsToProtocol:@protocol(SKGroupSetting)]) {
				NSMutableDictionary* section = [NSMutableDictionary dictionary];
				[section setValue:setting forKey:SKGroupKey];
				[section setValue:[NSMutableArray array] forKey:SKVisibleRowsKey];
				[sections addObject:section];
				currentGroup = (SKSetting<SKGroupSetting>*) setting;
			}
			else {
				if (!currentGroup) {
					SKSetting* group = [SKSetting settingWithDictionary:@{SKType : SKPSGroupSpecifier} viewController:self];
					NSMutableDictionary* section = [NSMutableDictionary dictionary];
					[section setValue:group forKey:SKGroupKey];
					[section setValue:[NSMutableArray array] forKey:SKVisibleRowsKey];
					[sections addObject:section];
					currentGroup = (SKSetting<SKGroupSetting>*) group;
				}
				[currentGroup.settings addObject:setting];
			}
		}
	}
	
	for (NSDictionary* section in self.sections) {
		SKSetting<SKGroupSetting>* group = [section valueForKey:SKGroupKey];
		if (!group.hidden)
			[self.visibleSections addObject:section];
		for (SKSetting* setting in group.settings)
			if (!setting.hidden)
				[[section valueForKey:SKVisibleRowsKey] addObject:setting];
	}
}

@end
