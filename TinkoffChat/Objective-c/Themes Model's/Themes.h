//
//  Themes.h
//  TinkoffChat
//
//  Created by Konstantin on 04/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

//#ifndef Themes_h
//#define Themes_h

#import <UIKit/UIKit.h>

@interface Themes : NSObject {
    UIColor *_lightColor;
    UIColor *_blueColor;
    UIColor *_blackColor;
}

- (instancetype) initFirstTheme: (UIColor *)lightColor secondTheme: (UIColor *)grayColor thirdTheme: (UIColor *)yellowColor;
- (void) dealloc;

@property (retain, nonatomic) UIColor* lightColor;
@property (retain, nonatomic) UIColor* grayColor;
@property (retain, nonatomic) UIColor* yellowColor;


@end


//#endif /* Themes_h */
