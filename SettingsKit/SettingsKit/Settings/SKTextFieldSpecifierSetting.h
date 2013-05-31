//
//  SKTextFieldSpecifierSetting.h
//  SettingsKit
//
//  Created by mr_depth on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKKeyValueSetting.h"

@interface SKTextFieldSpecifierSetting : SKKeyValueSetting
@property (nonatomic, readonly) BOOL secureTextEntry;
@property (nonatomic, readonly) UIKeyboardType keyboardType;
@property (nonatomic, readonly) UITextAutocapitalizationType autocapitalizationType;
@property (nonatomic, readonly) UITextAutocorrectionType autocorrectionType;
@property (nonatomic, readonly, retain) NSString* placeholder;

@end
