//
//  SKTitleValueSpecifierSetting.h
//  SettingsKit
//
//  Created by Artem Shimanski on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKMultiValueSetting.h"

@interface SKTitleValueSpecifierSetting : SKMultiValueSetting
@property (nonatomic, readonly) SEL action;
@property (nonatomic, readonly) UITableViewCellAccessoryType accessoryType;
@end
