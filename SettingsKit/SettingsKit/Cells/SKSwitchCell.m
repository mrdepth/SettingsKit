//
//  SKSwitchCell.m
//  SettingsKit
//
//  Created by Artem Shimanski on 15.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKSwitchCell.h"
#import "SKViewController.h"
#import "SKToggleSwitchSpecifierSetting.h"

@interface SKSwitchCell()
@property (nonatomic, retain) SKToggleSwitchSpecifierSetting* setting;
@end

@implementation SKSwitchCell
@synthesize switchView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#if ! __has_feature(objc_arc)
- (void)dealloc {
    [switchView release];
    [super dealloc];
}
#endif

- (NSObject*) value {
	return self.switchView.on ? [self.setting trueValue] : [self.setting falseValue];
}

- (void) setValue:(NSObject *)value {
	switchView.on = [(NSNumber*) value boolValue];
}

- (void) setSetting:(SKToggleSwitchSpecifierSetting *)setting {
	[super setSetting:setting];
	
	self.textLabel.text = setting.title;
	self.switchView.on = [setting.value isEqual:setting.trueValue];

	if (setting.image)
		self.imageView.image = [UIImage imageNamed:setting.image];
	else
		self.imageView.image = nil;
}

- (IBAction)onSwitch:(id)sender {
	[self didChangeValue];
}

@end
