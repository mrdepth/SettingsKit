//
//  SKSegmentedCell.m
//  SettingsKit
//
//  Created by Artem Shimanski on 16.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKSegmentedCell.h"
#import "SKViewController.h"
#import "SKSegmentedSpecifierSetting.h"

@interface SKSegmentedCell()
@property (nonatomic, retain) SKSegmentedSpecifierSetting* setting;
@end

@implementation SKSegmentedCell
@synthesize segmentView;

//- (void) setBackgroundView:(UIView *)backgroundView {
//
//}

#if ! __has_feature(objc_arc)
- (void)dealloc {
    [segmentView release];
    [super dealloc];
}
#endif

- (NSObject*) value {
	return [self.setting.values objectAtIndex:self.segmentView.selectedSegmentIndex];
}

- (void) setValue:(NSObject *)value {
	segmentView.selectedSegmentIndex = [self.setting.values indexOfObject:value];
}

- (IBAction)onChangeValue:(id)sender {
	[self didChangeValue];
}

- (void) setSetting:(SKSegmentedSpecifierSetting *)setting {
	[super setSetting:setting];
	self.textLabel.text = setting.title;
	self.textLabel.textAlignment = setting.textAlignment;
	
	UISegmentedControl* segmentedControl = [[UISegmentedControl alloc] initWithItems:setting.titles];
#if ! __has_feature(objc_arc)
	[segmentedControl autorelease];
#endif
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	[segmentedControl addTarget:self action:@selector(onChangeValue:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.selectedSegmentIndex = [setting.values indexOfObject:setting.value];
	self.accessoryView = segmentedControl;

	if (setting.image)
		self.imageView.image = [UIImage imageNamed:setting.image];
	else
		self.imageView.image = nil;
}

@end
