//
//  SKChildPaneCell.m
//  SettingsKit
//
//  Created by mr_depth on 18.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKChildPaneCell.h"
#import "SKChildPaneSpecifierSetting.h"
#import "SKViewController.h"

@interface SKChildPaneCell()
@property (nonatomic, retain) SKChildPaneSpecifierSetting* setting;
@end

@implementation SKChildPaneCell

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

- (void) setSetting:(SKChildPaneSpecifierSetting *)setting {
	[super setSetting:setting];
	
	self.textLabel.text = setting.title;
	self.textLabel.textAlignment = setting.textAlignment;
	self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	if (setting.image)
		self.imageView.image = [UIImage imageNamed:setting.image];
	else
		self.imageView.image = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	if (selected) {
		SKViewController* controller = [SKViewController viewControllerWithContentsOfFile:self.setting.file bundle:self.setting.viewController.bundle settingsObject:self.setting.viewController.settingsObject];
		[self.setting.viewController.navigationController pushViewController:controller animated:YES];
	}
}

@end
