//
//  SKCell.m
//  SettingsKit
//
//  Created by Artem Shimanski on 15.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKCell.h"
#import "SKKeyValueSetting.h"
#import "SKViewController.h"

@implementation SKCell
@synthesize setting;
@synthesize delegate;

+ (BOOL) allowsReusing {
	return YES;
}

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

- (void) dealloc {
	[setting release];
	[super dealloc];
}

- (NSObject*) value {
	return nil;
}

- (void) setValue:(NSObject *)value {
}

- (void)didChangeValue {
	if ([self.setting isKindOfClass:[SKKeyValueSetting class]]) {
		SKKeyValueSetting* keyValueSetting = (SKKeyValueSetting*) self.setting;
		BOOL canChangeValue = YES;
		NSObject* value = self.value;
		
		if ([self.setting.viewController respondsToSelector:keyValueSetting.shouldChangeValueSelector]) {
			NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:[self.setting.viewController methodSignatureForSelector:keyValueSetting.shouldChangeValueSelector]];
			[invocation setTarget:keyValueSetting.viewController];
			[invocation setSelector:keyValueSetting.shouldChangeValueSelector];
			[invocation setArgument:&value atIndex:2];
			[invocation invoke];
			[invocation getReturnValue:&canChangeValue];
		}
		if (canChangeValue) {
			keyValueSetting.value = value;
			
			if ([self.setting.viewController respondsToSelector:keyValueSetting.didChangeValueSelector]) {
				NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:[self.setting.viewController methodSignatureForSelector:keyValueSetting.didChangeValueSelector]];
				[invocation setTarget:keyValueSetting.viewController];
				[invocation setSelector:keyValueSetting.didChangeValueSelector];
				[invocation setArgument:&value atIndex:2];
				[invocation invoke];
			}
			[self.setting.viewController updateAnimated:YES];
		}
	}
}

@end
