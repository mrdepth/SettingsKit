//
//  SKMultiValueSpecifierSetting.h
//  SettingsKit
//
//  Created by mr_depth on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKMultiValueSetting.h"

@interface SKMultiValueSpecifierSetting : SKMultiValueSetting
@property (nonatomic, readonly, retain) NSArray* shortTitles;
@property (nonatomic, readonly) NSString* valueShortTitle;
@end
