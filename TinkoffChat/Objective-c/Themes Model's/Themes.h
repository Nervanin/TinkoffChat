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

- (instancetype) initFirstTheme: (UIColor *)lightColor secondTheme: (UIColor *)blueColor thirdTheme: (UIColor *)blackColor;
- (void) dealloc;

@property (retain, nonatomic) UIColor* lightColor;
@property (retain, nonatomic) UIColor* blueColor;
@property (retain, nonatomic) UIColor* blackColor;


@end


//#endif /* Themes_h */
