//
//  MoviesViewController.m
//  Flix
//
//  Created by dylanfdl on 6/23/21.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
// In Objective-C, @property creates a private instance variable and also automatically creates a getter and setter method for you
// nonatomic and strong specify how the compiler should generate the getter and setter method
// strong means this variable will retain its value over time ? (wasn't explained clearly)
// nonatomic - this will be common for us (also wasn't explained)
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) NSArray *filteredMovies;

// UIRefreshControl is an object that handles refreshing
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarLabel;


@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"purp_gradient.png"]]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBarLabel.delegate = self;
    // Do any additional setup after loading the view.
    
    // start Animating while fetch movies is happening
    [self.loadingIndicator startAnimating];
    [self fetchMovies];
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    // use @selector to specify which function an action calls
    // addTarget is being applied to refreshControl
    // forControlEvents specifies what triggers this refresh control, so in this case when refreshing event changes (someone pulls down) it starts the action
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    
    // addSubview places the refreshing component on top of the current highest component
    //[self.tableView addSubview:self.refreshControl];
    
    // insertSubview place the refreshing component at a specified Z index
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)fetchMovies{
    // Network Request --> Upon the screen loading it immediately makes a network call
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
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
                       [self fetchMovies];// handles reponse here
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

               // TODO: Get the array of movies
               // TODO: Store the movies in a property to use elsewhere
               // TODO: Reload your table view data
               // results is one key of the many that the api returns
               self.movies = dataDictionary[@"results"];
               self.filteredMovies = self.movies;
               [self.tableView reloadData];
           }
        [self.refreshControl endRefreshing];
       }];
    [task resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredMovies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // IMPORTANT LINE
    // Alloc vs init ?
    // Alloc actually creates space for something in memory
    // Init brings this said memory into your Storyboard
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movie = self.filteredMovies[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"overview"];
    
    // Setting up the url which combines a base url string and the path returned from the api for a given cell
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    // NSLog(posterURLString);
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    
    // Basically the same as NSString except it checks first if the string is a valid URL
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    // clear the image so you immediately start downloading the current one
    cell.posterView.image = nil;
    [cell.posterView setImageWithURL:posterURL];
    // STOP ANIMATION AFTER the second network request which retrieves photo from url :)
    [self.loadingIndicator stopAnimating];
    return cell;
}

// for search bar
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
        
        // checks if title contains a char
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(title CONTAINS[cd] %@)", searchText];
        self.filteredMovies = [self.movies filteredArrayUsingPredicate:predicate];
        NSLog(@"%@", self.filteredMovies);
                
    }
    else {
        self.filteredMovies = self.movies;
    }
    
    [self.tableView reloadData];
 
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBarLabel.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBarLabel.showsCancelButton = NO;
    self.searchBarLabel.text = @"";
    [self.searchBarLabel resignFirstResponder];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableViewCell *tappedCell = sender;
    // Finding index path to access the dict row
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    NSDictionary *movie = self.movies[indexPath.row];
    
    DetailsViewController *detailViewController = [segue destinationViewController];
    detailViewController.movie = movie;
}


@end
