//
//  SKSliderCell.h
//  SettingsKit
//
//  Created by Artem Shimanski on 15.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKSliderCell.h"
#import "SKSliderSpecifierSetting.h"

@interface SKSliderCell()
@property (nonatomic, retain) SKSliderSpecifierSetting* setting;
@end

@implementation SKSliderCell
@synthesize sliderView;

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

#if ! __has_feature(objc_arc)
- (void)dealloc {
	[sliderView release];
	[super dealloc];
}
#endif

- (NSObject*) value {
	return @(sliderView.value);
}

- (void) setValue:(NSObject *)value {
	sliderView.value = [(NSNumber*) value floatValue];
}

- (IBAction)onChangeValue:(id)sender {
	[self didChangeValue];
}

- (void) setSetting:(SKSliderSpecifierSetting *)setting {
	[super setSetting:setting];
	self.sliderView.minimumValue = [setting.minimumValue floatValue];
	self.sliderView.maximumValue = [setting.maximumValue floatValue];
	self.value = setting.value;
}

@end
