//
//  GrowingTextViewHandler.h
//  GrowingTextViewHandler-objc
//
//  Created by hsusmita on 13/03/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GrowingTextViewHandler : NSObject

@property (nonatomic, strong) UITextView *growingTextView;
@property (nonatomic, assign) CGFloat animationDuration;

- (id)initWithTextView:(UITextView *)textView withHeightConstraint:(NSLayoutConstraint *)heightConstraint;
- (void)resizeTextViewWithAnimation:(BOOL)animated;
- (void)updateMinimumNumberOfLines:(NSInteger)minimumNumberOfLines andMaximumNumberOfLine:(NSInteger)maximumNumberOfLines;

@end
