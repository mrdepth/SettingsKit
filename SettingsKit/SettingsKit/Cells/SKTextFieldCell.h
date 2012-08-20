//
//  SKTextFieldCell.h
//  SettingsKit
//
//  Created by Artem Shimanski on 15.08.12.
//  Copyright (c) 2012 Artem Shimanski. All rights reserved.
//

#import "SKCell.h"
#import "CaptionTextField.h"

@interface SKTextFieldCell : SKCell<UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet CaptionTextField *textField;
- (IBAction)onChangeText:(id)sender;

@end
