//
//  SKDestructiveButtonCell.m
//  SettingsKit
//
//  Created by Artem Shimanski on 11.10.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKDestructiveButtonCell.h"
#import "SKDestructiveButtonSetting.h"

@interface SKDestructiveButtonCell()
@property (nonatomic, retain) SKDestructiveButtonSetting* setting;

- (IBAction)onButton:(id)sender;

@end

@implementation SKDestructiveButtonCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) awakeFromNib {
	UIImage* image = [UIImage imageNamed:@"SettingsKit.bundle/destructiveButton.png"];
	image = [image stretchableImageWithLeftCapWidth:20 topCapHeight:0];
	[self.button setBackgroundImage:image forState:UIControlStateNormal];
}

- (void) setSetting:(SKDestructiveButtonSetting *)setting {
	[super setSetting:setting];
	
	[self.button setTitle:setting.title forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	if (selected) {
		if (self.setting.action)
			[self.setting.viewController performSelector:self.setting.action withObject:self];
	}
}

#pragma mark - Private

- (IBAction)onButton:(id)sender {
	if (self.setting.action)
		[self.setting.viewController performSelector:self.setting.action withObject:self];
}

@end
