//
//  SKMultiValueSetting.h
//  SettingsKit
//
//  Created by Artem Shimanski on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKKeyValueSetting.h"

@interface SKMultiValueSetting : SKKeyValueSetting
@property (nonatomic, readonly, retain) NSArray* values;
@property (nonatomic, readonly, retain) NSArray* titles;
@property (nonatomic, readonly, retain) NSArray* images;
@property (nonatomic, readonly) NSString* valueTitle;
@property (nonatomic, readonly) NSString* valueImage;

@end
