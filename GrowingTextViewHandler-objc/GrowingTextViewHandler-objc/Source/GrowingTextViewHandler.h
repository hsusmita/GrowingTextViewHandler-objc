//
//  GrowingTextViewHandler.h
//  GrowingTextViewHandler-objc
//
//  Created by hsusmita on 13/03/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 An NSObject subclass to handle resizing of UITextView as the user types in. The textview resizes as long as the number of lines lies between specified minimum and maximum number of lines. This class calculates total size of UITextView text and adjusts the height constraint of that UITextView. You need to provide height constraint to UITextView.
 */

@interface GrowingTextViewHandler : NSObject

@property (nonatomic, strong) UITextView *growingTextView;
@property (nonatomic, assign) CGFloat animationDuration;

/** Returns an instance of GrowingTextViewHandler
 @param textView The UITextView which needs to be resized
 @param heightConstraint The height constraint of textview
 */
- (id)initWithTextView:(UITextView *)textView withHeightConstraint:(NSLayoutConstraint *)heightConstraint;

/** Limits resizing of UITextView between minimumNumberOfLines and maximumNumberOfLines
 @param minimumNumberOfLines Lower limit on number of lines
 @param maximumNumberOfLines Upper limit on number of lines
 */
- (void)updateMinimumNumberOfLines:(NSInteger)minimumNumberOfLines andMaximumNumberOfLine:(NSInteger)maximumNumberOfLines;

/** Resizes the textView according to the amount of text. 
 @param animated Specify YES if you want to animate the size change of UITextView or NO if you don't
 */

- (void)resizeTextViewWithAnimation:(BOOL)animated;

/** Sets text of textView and resizes it according to the length of the text
 @param animated Specify YES if you want to animate the size change of UITextView or NO if you don't
 */
- (void)setText:(NSString *)text withAnimation:(BOOL)animated;

@end
