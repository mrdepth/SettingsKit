//
//  SKCell.h
//  SettingsKit
//
//  Created by Artem Shimanski on 15.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKSetting;
@class SKCell;
@protocol SCTableViewCellDelegate
- (void) cell:(SKCell*) cell didChangeValue:(NSObject*) value;
@end

@interface SKCell : UITableViewCell
@property (nonatomic, retain) SKSetting* setting;
@property (nonatomic, retain) NSObject* value;
@property (nonatomic, assign) id<SCTableViewCellDelegate> delegate;

+ (BOOL) allowsReusing;
- (void)didChangeValue;

@end
