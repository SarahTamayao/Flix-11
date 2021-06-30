//
//  MovieApiManager.h
//  Flix
//
//  Created by dylanfdl on 6/30/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieApiManager : UIViewController
- (id)init;
- (void)fetchNowPlaying:(void(^)(NSArray *movies, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
