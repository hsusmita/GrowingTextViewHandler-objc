//
//  GrowingTextViewHandler.m
//  GrowingTextViewHandler-objc
//
//  Created by hsusmita on 13/03/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import "GrowingTextViewHandler.h"

@interface GrowingTextViewHandler()

@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;
@property (nonatomic, assign) CGFloat initialHeight;

@end

@implementation GrowingTextViewHandler

- (id)initWithTextView:(UITextView *)textView withHeightConstraint:(NSLayoutConstraint *)heightConstraint {
  self = [super init];
  if (self) {
    self.growingTextView = textView;
    self.heightConstraint = heightConstraint;
    self.minimumNumberOfLines = 2;
    self.maximumNumberOfLines = 3;
    self.animationDuration = 0.7;
    [self updateInitialHeightAndResize];
  }
  return self;
}

- (void)setMinimumNumberOfLines:(NSInteger)minimumNumberOfLines {
  _minimumNumberOfLines = minimumNumberOfLines;
  [self updateInitialHeightAndResize];
}

- (void)updateInitialHeightAndResize {
  self.initialHeight = [self estimatedInitialHeight];
  [self resizeTextViewWithAnimation:NO];
}

- (CGFloat)estimatedInitialHeight {
  CGFloat caretHeight = [self.growingTextView caretRectForPosition:self.growingTextView.selectedTextRange.end].size.height;
  CGFloat totalHeight = caretHeight * self.minimumNumberOfLines + self.growingTextView.textContainerInset.top + self.growingTextView.textContainerInset.bottom;
  return fmax(totalHeight,self.growingTextView.frame.size.height);
}

- (void)resizeTextViewWithAnimation:(BOOL)animated {
  NSInteger textViewNumberOfLines = self.currentNumberOfLines;
  if (textViewNumberOfLines <= self.minimumNumberOfLines) {
    [self updateVerticalAlignmentWithHeight:self.initialHeight animated:animated];
    [self.growingTextView setContentOffset:CGPointZero animated:YES];
  }else if ((textViewNumberOfLines > self.minimumNumberOfLines) && (textViewNumberOfLines <= self.maximumNumberOfLines)) {
    CGFloat currentHeight = [self currentHeight];
    CGFloat verticalAlignmentConstant = (currentHeight > self.initialHeight) ? currentHeight : self.initialHeight;
    [self updateVerticalAlignmentWithHeight:verticalAlignmentConstant animated:animated];
    [self.growingTextView setContentOffset:CGPointZero animated:YES];
  }
}

- (CGFloat)currentHeight {
  return self.growingTextView.contentSize.height;
}

- (NSInteger) currentNumberOfLines  {
  CGFloat caretHeight = [self.growingTextView caretRectForPosition:self.growingTextView.selectedTextRange.end].size.height;
  CGFloat totalHeight = self.growingTextView.contentSize.height + self.growingTextView.textContainerInset.top + self.growingTextView.textContainerInset.bottom;
  NSInteger numberOfLines = (totalHeight/caretHeight) - 1;
  return numberOfLines;
}

- (void)updateVerticalAlignmentWithHeight:(CGFloat)height animated:(BOOL)animated {
  self.heightConstraint.constant = height;
  if (animated == true) {
    [UIView animateWithDuration:self.animationDuration
                     animations:^{
      [self.growingTextView.superview layoutIfNeeded];
    }
                     completion:nil];
  }
   else {
    [self.growingTextView.superview layoutIfNeeded];
  }
}

@end
