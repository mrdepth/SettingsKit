//
//  SKGroupSetting.h
//  SettingsKit
//
//  Created by mr_depth on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SKGroupSetting <NSObject>
@property (nonatomic, readonly, retain) NSString* footerText;
@property (nonatomic, readonly, retain) NSMutableArray* settings;
@end
