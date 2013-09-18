//
//  SKTitleValueCell.m
//  SettingsKit
//
//  Created by mr_depth on 18.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKTitleValueCell.h"
#import "SKTitleValueSpecifierSetting.h"
#import "SKViewController.h"

@interface SKTitleValueCell()
@property (nonatomic, retain) SKTitleValueSpecifierSetting* setting;
@end

@implementation SKTitleValueCell

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

- (void) setSetting:(SKTitleValueSpecifierSetting *)setting {
	[super setSetting:setting];
	
	self.textLabel.text = setting.title;
	self.textLabel.textAlignment = setting.textAlignment;
	NSString* valueTitle = setting.valueTitle;
	if (!valueTitle) {
		NSObject* value = setting.value;
		if ([value isKindOfClass:[NSString class]])
			valueTitle = (NSString*) value;
	}
	self.detailTextLabel.text = valueTitle;

	self.accessoryView = nil;

	if (setting.accessoryImage)
		self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:setting.accessoryImage]];
	else {
		self.accessoryType = setting.accessoryType;
	}

	NSString* image = setting.image;
	if (!image)
		image = setting.valueImage;
	if (image)
		self.imageView.image = [UIImage imageNamed:image];
	else
		self.imageView.image = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	if (selected) {
		if (self.setting.action)
			[self.setting.viewController performSelector:self.setting.action withObject:self];
	}
}

- (void) layoutSubviews {
	[super layoutSubviews];
	if (self.textLabel.textAlignment == NSTextAlignmentCenter) {
		self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, self.frame.size.width - self.textLabel.frame.origin.x * 2, self.textLabel.frame.size.height);
	}
}

@end
