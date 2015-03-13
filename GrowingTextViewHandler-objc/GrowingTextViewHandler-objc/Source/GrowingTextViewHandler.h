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
@property (nonatomic, assign) NSInteger maximumNumberOfLines;
@property (nonatomic, assign) NSInteger minimumNumberOfLines;
@property (nonatomic, assign) CGFloat animationDuration;

@end
