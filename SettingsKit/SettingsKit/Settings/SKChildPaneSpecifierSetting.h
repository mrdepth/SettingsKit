//
//  SKChildPaneSpecifierSetting.h
//  SettingsKit
//
//  Created by mr_depth on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKSetting.h"

@interface SKChildPaneSpecifierSetting : SKSetting
@property (nonatomic, readonly, retain) NSString* file;
@property (nonatomic, readonly) SEL shouldPerformAction;
@end
