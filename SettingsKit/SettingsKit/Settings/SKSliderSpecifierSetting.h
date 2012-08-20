//
//  SKSliderSpecifierSetting.h
//  SettingsKit
//
//  Created by mr_depth on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKKeyValueSetting.h"

@interface SKSliderSpecifierSetting : SKKeyValueSetting
@property (nonatomic, readonly, retain) NSNumber* minimumValue;
@property (nonatomic, readonly, retain) NSNumber* maximumValue;
@property (nonatomic, readonly, retain) NSString* minimumValueImage;
@property (nonatomic, readonly, retain) NSString* maximumValueImage;

@end
