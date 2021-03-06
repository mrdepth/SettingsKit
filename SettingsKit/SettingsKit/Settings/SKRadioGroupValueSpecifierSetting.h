//
//  SKRadioGroupValueSpecifierSetting.h
//  SettingsKit
//
//  Created by mr_depth on 18.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKSetting.h"

@class SKRadioGroupSpecifierSetting;
@interface SKRadioGroupValueSpecifierSetting : SKSetting
@property (nonatomic, readonly, retain) NSObject* value;
@property (nonatomic, readonly, assign) SKRadioGroupSpecifierSetting* radioGroup;

- (id) initWithRadioGroup:(SKRadioGroupSpecifierSetting*) radioGroup value:(NSObject*) value title:(NSString*) title image:(NSString*) image viewController:(SKViewController *)viewController;

@end
