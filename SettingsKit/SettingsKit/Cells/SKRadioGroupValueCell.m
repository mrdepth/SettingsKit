//
//  SKRadioGroupValueCell.m
//  SettingsKit
//
//  Created by mr_depth on 18.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKRadioGroupValueCell.h"
#import "SKRadioGroupSpecifierSetting.h"
#import "SKRadioGroupValueSpecifierSetting.h"
#import "SKViewController.h"
#import <objc/runtime.h>

@interface SKRadioGroupValueCell()
@property (nonatomic, retain) SKRadioGroupValueSpecifierSetting* setting;
@end

@implementation SKRadioGroupValueCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (NSObject*) value {
	return self.setting.value;
}

- (void)didChangeValue {
	BOOL canChangeValue = YES;
	NSObject* value = self.value;
	
	SKViewController* viewController = objc_getAssociatedObject(self.setting.viewController, @"parentSKViewController");
	if (!viewController)
		viewController = self.setting.viewController;
	
	if ([viewController respondsToSelector:self.setting.radioGroup.shouldChangeValueSelector]) {
		NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:[viewController methodSignatureForSelector:self.setting.radioGroup.shouldChangeValueSelector]];
		[invocation setTarget:viewController];
		[invocation setSelector:self.setting.radioGroup.shouldChangeValueSelector];
		[invocation setArgument:&value atIndex:2];
		[invocation invoke];
		[invocation getReturnValue:&canChangeValue];
	}
	if (canChangeValue) {
		self.setting.radioGroup.value = value;
		
		if ([viewController respondsToSelector:self.setting.radioGroup.didChangeValueSelector]) {
			NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:[viewController methodSignatureForSelector:self.setting.radioGroup.didChangeValueSelector]];
			[invocation setTarget:viewController];
			[invocation setSelector:self.setting.radioGroup.didChangeValueSelector];
			[invocation setArgument:&value atIndex:2];
			[invocation invoke];
		}
		[self.setting.viewController updateAnimated:YES];
	}
}

- (void) setSetting:(SKRadioGroupValueSpecifierSetting *)setting {
	[super setSetting:setting];
	
	self.textLabel.text = setting.title;
	self.textLabel.textAlignment = setting.textAlignment;
	self.detailTextLabel.text = nil;
	self.accessoryType = [setting.value isEqual:setting.radioGroup.value] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	if (setting.image)
		self.imageView.image = [UIImage imageNamed:setting.image];
	else
		self.imageView.image = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	if (selected) {
		NSObject* oldValue = self.setting.radioGroup.value;
		if ([self didChangeValue]) {
			NSObject* newValue = self.setting.radioGroup.value;
			if (newValue && oldValue && ![newValue isEqual:oldValue]) {
				NSIndexPath* indexPath = [self.setting.viewController.tableView indexPathForCell:self];
				SKRadioGroupValueCell* cell = (SKRadioGroupValueCell*) [self.setting.viewController.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[self.setting.radioGroup.values indexOfObject:oldValue] inSection:indexPath.section]];
				cell.accessoryType = UITableViewCellAccessoryNone;
				self.accessoryType = UITableViewCellAccessoryCheckmark;
				
			}
		}
	}
}

@end
