//
//  SKSetting.h
//  SettingsKit
//
//  Created by Artem Shimanski on 17.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKViewController;
@interface SKSetting : NSObject
@property (nonatomic, readonly, assign) SKViewController* viewController;
@property (nonatomic, readonly, retain) NSString* title;
@property (nonatomic, readonly, retain) NSString* image;
@property (nonatomic, readonly, retain) NSString* onlyDisplayOnInterfaceIdiom;
@property (nonatomic, readonly, getter = isHidden) BOOL hidden;

+ (id) settingWithDictionary:(NSDictionary*) dictionary viewController:(SKViewController*) viewController;
- (id) initWithDictionary:(NSDictionary*) dictionary viewController:(SKViewController*) viewController;
- (id) initWithViewController:(SKViewController*) aViewController;

@end
