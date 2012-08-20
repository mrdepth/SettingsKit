//
//  SKSegmentedCell.h
//  SettingsKit
//
//  Created by Artem Shimanski on 16.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKCell.h"

@interface SKSegmentedCell : SKCell
@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentView;
- (IBAction)onChangeValue:(id)sender;

@end
