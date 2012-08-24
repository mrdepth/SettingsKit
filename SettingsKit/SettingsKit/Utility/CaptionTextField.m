//
//  CaptionTextField.m
//  
//
//  Created by mr_depth on 17.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CaptionTextField.h"

@implementation CaptionTextField
@synthesize captionLabel;

#if ! __has_feature(objc_arc)
- (void) dealloc {
	[captionLabel release];
	[super dealloc];
}
#endif

- (UILabel*) captionLabel {
	if (!captionLabel) {
		captionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		captionLabel.backgroundColor = [UIColor clearColor];
		captionLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
		captionLabel.textColor = [UIColor blackColor];
		self.leftView = captionLabel;
		self.leftViewMode = UITextFieldViewModeAlways;
	}
	return captionLabel;
}

- (void) setCaption:(NSString *)caption {
	self.captionLabel.text = caption;
}

- (NSString*) caption {
	return self.captionLabel.text;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
	CGRect r;
	r.size = [captionLabel sizeThatFits:bounds.size];
	r.size.width += 5;
	r.size.height = bounds.size.height - 2;
	r.origin = CGPointMake(10, 0);
	return r;
}

@end
