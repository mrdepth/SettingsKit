//
//  SKToggleSwitchSpecifierSetting.h
//  SettingsKit
//
//  Created by mr_depth on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKKeyValueSetting.h"

@interface SKToggleSwitchSpecifierSetting : SKKeyValueSetting
@property(nonatomic, readonly, retain) NSObject* trueValue;
@property(nonatomic, readonly, retain) NSObject* falseValue;

@end
