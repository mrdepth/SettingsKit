//
//  SKSwitchCell.h
//  SettingsKit
//
//  Created by Artem Shimanski on 15.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKCell.h"

@interface SKSwitchCell : SKCell
@property (retain, nonatomic) IBOutlet UISwitch *switchView;

- (IBAction)onSwitch:(id)sender;

@end
