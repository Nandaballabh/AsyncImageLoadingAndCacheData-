//
//  UIImageView+Addition.m
//  SuryaInterView
//
//  Created by Nanda Ballabh on 8/26/15.
//  Copyright (c) 2015 Nanda Ballabh. All rights reserved.
//

#import "UIImageView+Addition.h"

@implementation UIImageView (Addition)

- (void) setImageWithURl:(NSString *)url placeHolderimage:(UIImage *) image {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.image = image;
                });
            }
        }
    });
}


@end
