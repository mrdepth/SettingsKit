//
//  SKKeyValueSetting.h
//  SettingsKit
//
//  Created by Artem Shimanski on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKSetting.h"

@interface SKKeyValueSetting : SKSetting
@property (nonatomic, readonly, retain) NSString* key;
@property (nonatomic, retain) NSObject* value;
@property (nonatomic, readonly, retain) NSObject* defaultValue;
@property (nonatomic, readonly) SEL shouldChangeValueSelector;
@property (nonatomic, readonly) SEL didChangeValueSelector;
@property (nonatomic, readonly) UITableViewCellAccessoryType accessoryType;
@property (nonatomic, retain) NSString* accessoryImage;


@end
