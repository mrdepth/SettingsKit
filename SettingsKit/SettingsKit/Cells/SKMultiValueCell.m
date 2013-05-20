//
//  SKMultiValueCell.m
//  SettingsKit
//
//  Created by mr_depth on 18.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKMultiValueCell.h"
#import "SKMultiValueSpecifierSetting.h"
#import "SKViewController.h"
#import <objc/runtime.h>

@interface SKMultiValueCell()
@property (nonatomic, retain) SKMultiValueSpecifierSetting* setting;
@end

@implementation SKMultiValueCell

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

- (void) setSetting:(SKMultiValueSpecifierSetting *)setting {
	[super setSetting:setting];
	
	self.textLabel.text = setting.title;
	self.textLabel.textAlignment = setting.textAlignment;
	self.detailTextLabel.text = setting.valueShortTitle;

	if (setting.accessoryImage)
		self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:setting.accessoryImage]];
	else {
		self.accessoryView = nil;
		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

		
//	self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	NSString* image = setting.valueImage;
	if (image)
		self.imageView.image = [UIImage imageNamed:image];
	else
		self.imageView.image = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	if (selected) {
		NSMutableDictionary* group = [NSMutableDictionary dictionaryWithDictionary:@{SKType : SKPSRadioGroupSpecifier, SKKey : self.setting.key, SKTitles : self.setting.titles, SKValues : self.setting.values, SKDefaultValue : self.setting.defaultValue}];
		[group setValue:self.setting.accessoryCheckmarkImage forKey:SKAccessoryCheckmarkImage];

		NSMutableDictionary* preferences = [NSMutableDictionary dictionary];
		[preferences setValue:self.setting.title forKey:SKTitle];
		[preferences setValue:@[group] forKey:SKPreferenceSpecifiers];
		if (self.setting.viewController.stringsTable)
			[preferences setValue:self.setting.viewController.stringsTable forKey:SKStringsTable];
		
		if (self.setting.className)
			[preferences setValue:self.setting.className forKey:SKClassName];
		
		SKViewController* controller = [SKViewController viewControllerWithPreferences:preferences bundle:self.setting.viewController.bundle settingsObject:self.setting.viewController.settingsObject];
		objc_setAssociatedObject(controller, @"parentSKViewController", self.setting.viewController, OBJC_ASSOCIATION_ASSIGN);
		
		[self.setting.viewController.navigationController pushViewController:controller animated:YES];
	}
}
@end
