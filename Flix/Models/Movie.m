//
//  Movie.m
//  Flix
//
//  Created by dylanfdl on 6/30/21.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary {
  self = [super init];

  self.title = dictionary[@"title"];
  self.posterUrl = dictionary[@"poster_path"];
  self.overview_text = dictionary[@"overview"];

  // Set the other properties from the dictionary

  return self;
  }

+ (NSMutableArray *)moviesWithDictionaries:(NSArray *)dictionaries {
   // Implement this function
    NSMutableArray *returned_array = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        // casted a movie... not sure if this is right
        Movie *movie = [[Movie alloc] initWithDictionary:dictionary];// Call the Movie initializer here
        NSLog(@"URL: %@", movie.posterUrl);
        [returned_array addObject:movie];
    }
    return returned_array;
}

@end
