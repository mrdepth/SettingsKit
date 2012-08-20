//
//  SKSliderCell.h
//  SettingsKit
//
//  Created by Artem Shimanski on 15.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKCell.h"

@interface SKSliderCell : SKCell
@property (retain, nonatomic) IBOutlet UISlider *sliderView;
- (IBAction)onChangeValue:(id)sender;

@end
