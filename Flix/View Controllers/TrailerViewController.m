//
//  TrailerViewController.m
//  Flix
//
//  Created by dylanfdl on 6/25/21.
//

#import "TrailerViewController.h"
#import <WebKit/WebKit.h>

@interface TrailerViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *trailerWebView;

@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchTrailer];
    

    // Do any additional setup after loading the view.
}

- (void)fetchTrailer{
    // Network Request --> Upon the screen loading it immediately makes a network call
    NSString *pre_url = @"https://api.themoviedb.org/3/movie/";
    NSString *mid_url = [pre_url stringByAppendingString:_customID];
    NSString *all = [mid_url stringByAppendingString:@"/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURL *url = [NSURL URLWithString:all];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    // Completion Handler -> contains an Objective-C BLOCK inside of the { }
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               // ERROR here means no internet connection
               // Creates the alert modal
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot Get Movies" message:@"The internet connection appears to be offline." preferredStyle:(UIAlertControllerStyleAlert)];
               
               // create an OK action
               UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                       [self fetchTrailer];// handles reponse here
                   }];
               // add the OK action to the alert controller
               [alert addAction:okAction];
               
               // shows the UIAlertController on the storyboard
               [self presentViewController:alert animated:YES completion:^{
                   // optional code for what happens after the alert controller has finished presenting
               }];
               
               // NSLog(@"%@", [error localizedDescription]);
           }
           else {
               // NSDictionary is dict data structure
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               NSDictionary *trailer = (dataDictionary[@"results"])[0];

               NSString *key = [trailer objectForKey:@"key"];
               NSString *trailerURL = [@"https://www.youtube.com/watch?v=" stringByAppendingString:key];
               
               NSURL *trailerFinalurl = [NSURL URLWithString:@"https://www.google.com"];
               
               // Place the URL in a URL Request.
               NSURLRequest *request = [NSURLRequest requestWithURL:trailerFinalurl
                                                        cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                    timeoutInterval:10.0];
               // Load Request into WebView.
               [self.trailerWebView loadRequest:request];
               
               [self.trailerWebView reload];
           }
        //[self.refreshControl endRefreshing];
       }];
    [task resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
