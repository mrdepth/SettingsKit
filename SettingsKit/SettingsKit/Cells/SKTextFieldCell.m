//
//  SKTextFieldCell.m
//  SettingsKit
//
//  Created by Artem Shimanski on 15.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKTextFieldCell.h"
#import "SKTextFieldSpecifierSetting.h"
#import "SKViewController.h"

@interface SKViewController ()
@property (nonatomic, retain) NSMutableArray* visibleSections;
@end

@interface SKTextFieldCell()
@property (nonatomic, retain) SKTextFieldSpecifierSetting* setting;
@end

@implementation SKTextFieldCell
@synthesize textField;

+ (BOOL) allowsReusing {
	return NO;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#if ! __has_feature(objc_arc)
- (void)dealloc {
	[textField release];
	[super dealloc];
}
#endif

- (IBAction)onChangeText:(id)sender {
	[self didChangeValue];
}

- (NSObject*) value {
	return textField.text;
}

- (void) setValue:(NSObject *)value {
	textField.text = (NSString*) value;
}

- (void) setSetting:(SKTextFieldSpecifierSetting *)setting {
	[super setSetting:setting];
	
	self.textField.caption = setting.title;
	self.textField.text = (NSString*) setting.value;
	
	self.textField.secureTextEntry = setting.secureTextEntry;
	self.textField.keyboardType = setting.keyboardType;
	self.textField.autocapitalizationType = setting.autocapitalizationType;
	self.textField.autocorrectionType = setting.autocorrectionType;

	if (setting.image)
		self.imageView.image = [UIImage imageNamed:setting.image];
	else
		self.imageView.image = nil;
}

#pragma mark UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)aTextField {
	NSIndexPath* myIndexPath = [self.setting.viewController.tableView indexPathForCell:self];
	
	NSInteger numberOfSections = self.setting.viewController.visibleSections.count;
	NSInteger rowIndex = myIndexPath.row + 1;
	
	for (NSInteger sectionIndex = myIndexPath.section; sectionIndex < numberOfSections; sectionIndex++) {
		NSArray* rows = [[self.setting.viewController.visibleSections objectAtIndex:sectionIndex] valueForKey:SKVisibleRowsKey];
		NSInteger numberOfRows = rows.count;
		for (; rowIndex < numberOfRows; rowIndex++) {
			SKSetting* setting = [rows objectAtIndex:rowIndex];
			if ([setting isKindOfClass:[SKTextFieldSpecifierSetting class]]) {
				NSIndexPath* indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
				[self.setting.viewController.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
				SKTextFieldCell* cell = (SKTextFieldCell*) [self.setting.viewController tableView:self.setting.viewController.tableView cellForRowAtIndexPath:indexPath];
				[cell.textField becomeFirstResponder];
				return YES;
			}
		}
		rowIndex = 0;
	}
	[aTextField resignFirstResponder];
	return YES;
}

@end
