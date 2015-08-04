//
//  GrowingTextViewHandler.m
//  GrowingTextViewHandler-objc
//
//  Created by hsusmita on 13/03/15.
//  Copyright (c) 2015 hsusmita.com. All rights reserved.
//

#import "GrowingTextViewHandler.h"

static CGFloat kDefaultAnimationDuration = 0.5;
static NSInteger kMinimumNumberOfLines = 1;
static NSInteger kMaximumNumberOfLines = INT_MAX;

@interface GrowingTextViewHandler()

@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;
@property (nonatomic, assign) CGFloat initialHeight;
@property (nonatomic, assign) CGFloat maximumHeight;
@property (nonatomic, assign) NSInteger maximumNumberOfLines;
@property (nonatomic, assign) NSInteger minimumNumberOfLines;

@end

@implementation GrowingTextViewHandler

- (id)initWithTextView:(UITextView *)textView
  withHeightConstraint:(NSLayoutConstraint *)heightConstraint {
  self = [super init];
  if (self) {
    self.growingTextView = textView;
    self.heightConstraint = heightConstraint;
    self.animationDuration = kDefaultAnimationDuration;
    [self updateMinimumNumberOfLines:kMinimumNumberOfLines andMaximumNumberOfLine:kMaximumNumberOfLines];
  }
  return self;
}


#pragma mark - Public Methods

- (void)updateMinimumNumberOfLines:(NSInteger)minimumNumberOfLines
            andMaximumNumberOfLine:(NSInteger)maximumNumberOfLines {
  _minimumNumberOfLines = minimumNumberOfLines;
  _maximumNumberOfLines = maximumNumberOfLines;
  [self updateInitialHeightAndResize];
}

- (void)resizeTextViewWithAnimation:(BOOL)animated {
  NSInteger textViewNumberOfLines = self.currentNumberOfLines;
  CGFloat verticalAlignmentConstant = 0.0;
  if (textViewNumberOfLines <= self.minimumNumberOfLines) {
    verticalAlignmentConstant = self.initialHeight;
  }else if ((textViewNumberOfLines > self.minimumNumberOfLines) && (textViewNumberOfLines <= self.maximumNumberOfLines)) {
    CGFloat currentHeight = [self currentHeight];
    verticalAlignmentConstant = (currentHeight > self.initialHeight) ? currentHeight : self.initialHeight;
  }else if (textViewNumberOfLines > self.maximumNumberOfLines){
    verticalAlignmentConstant = self.maximumHeight;
  }
  if (self.growingTextView.frame.size.height != verticalAlignmentConstant) {
    [self updateVerticalAlignmentWithHeight:verticalAlignmentConstant animated:animated];
  }
  if (textViewNumberOfLines <= self.maximumNumberOfLines) {
    [self.growingTextView setContentOffset:CGPointZero animated:YES];
  }
}

#pragma mark - Private Helpers

- (void)updateInitialHeightAndResize {
  self.initialHeight = [self estimatedInitialHeight];
  self.maximumHeight = [self estimatedMaximumHeight];
  [self resizeTextViewWithAnimation:NO];
}

- (CGFloat)estimatedInitialHeight {
  CGFloat totalHeight = [self caretHeight] * self.minimumNumberOfLines + self.growingTextView.textContainerInset.top + self.growingTextView.textContainerInset.bottom;
  return fmax(totalHeight,self.growingTextView.frame.size.height);
}

- (CGFloat)estimatedMaximumHeight {
  CGFloat totalHeight = [self caretHeight] * self.maximumNumberOfLines + self.growingTextView.textContainerInset.top + self.growingTextView.textContainerInset.bottom;
  return totalHeight;
}

- (CGFloat)caretHeight {
  return [self.growingTextView caretRectForPosition:self.growingTextView.selectedTextRange.end].size.height;
}

- (CGFloat)currentHeight {
  CGFloat width = self.growingTextView.bounds.size.width - 2.0 * self.growingTextView.textContainer.lineFragmentPadding;
  CGRect boundingRect = [self.growingTextView.text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                      attributes:@{ NSFontAttributeName:self.growingTextView.font}
                                                         context:nil];
  CGFloat heightByBoundingRect = CGRectGetHeight(boundingRect) + self.growingTextView.font.lineHeight;
  return MAX(heightByBoundingRect,self.growingTextView.contentSize.height);
}


- (NSInteger)currentNumberOfLines  {
  CGFloat caretHeight = [self.growingTextView caretRectForPosition:self.growingTextView.selectedTextRange.end].size.height;
  CGFloat totalHeight = [self currentHeight] + self.growingTextView.textContainerInset.top + self.growingTextView.textContainerInset.bottom;
  NSInteger numberOfLines = (totalHeight/caretHeight) - 1;
  return numberOfLines;
}

- (void)updateVerticalAlignmentWithHeight:(CGFloat)height animated:(BOOL)animated {
  if ([self.delegate respondsToSelector:@selector(textView:willChangeHeight:)]) {
    [self.delegate textView:self.growingTextView willChangeHeight:CGRectGetHeight(self.growingTextView.frame)];
  }
  
  self.heightConstraint.constant = height;
  if (animated == true) {
    [UIView animateWithDuration:self.animationDuration
                     animations:^{
                       if (self.heightConstraint == nil) {
                         CGRect frame = self.growingTextView.frame;
                         frame.size.height = height;
                         self.growingTextView.frame = frame;
                       }else {
                         [self.growingTextView.superview layoutIfNeeded];
                       }
    }
                     completion:^(BOOL finished) {
                       if ([self.delegate respondsToSelector:@selector(textView:didChangeHeight:)]) {
                         [self.delegate textView:self.growingTextView didChangeHeight:height];
                       }
                     }];
  }
   else {
     if (self.heightConstraint == nil) {
       CGRect frame = self.growingTextView.frame;
       frame.size.height = height;
       self.growingTextView.frame = frame;
     }else {
       [self.growingTextView.superview layoutIfNeeded];
     }
     if ([self.delegate respondsToSelector:@selector(textView:didChangeHeight:)]) {
       [self.delegate textView:self.growingTextView didChangeHeight:height];
     }
   }
}

- (void)setText:(NSString *)text withAnimation:(BOOL)animated {
  self.growingTextView.text = text;
  if (text.length > 0) {
    [self resizeTextViewWithAnimation:animated];
  }else {
    [self updateVerticalAlignmentWithHeight:self.initialHeight animated:animated];
  }
}

@end
