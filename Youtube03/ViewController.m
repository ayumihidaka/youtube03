//
//  ViewController.m
//  Youtube03
//
//  Created by あゆみ on 2015/02/01.
//  Copyright (c) 2015年 あゆみ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    MPMoviePlayerController *moviePlayer;
    
}

@end

@implementation ViewController

@synthesize tableList;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    UITableView *table = [[UITableView alloc]initWithFrame:self.view.bounds];
    [table setDelegate:self];
    [table setDataSource:self];
    [self.view addSubview:table];
    tableList = [[NSMutableArray alloc] initWithObjects:@"play",@"manchesterunited", nil];
    self.tableList = tableList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *DisclosureButtonIdentifier = @"DisclosurebutotonIdentifier";
    UITableViewCell *cell = [tableView   dequeueReusableCellWithIdentifier:DisclosureButtonIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DisclosureButtonIdentifier];
    }
    NSInteger row = [indexPath row];
    NSString *rowString = [tableList objectAtIndex:row];
    cell.textLabel.text = rowString;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.ajisaba.net/motion/dnld.php?fpath=emu.mp4"];
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(endPlay:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:moviePlayer];
    //[[NSNotificationCenter defaultCenter] addObserver:self
     //                                        selector:@selector(stopBusyIndicator:)
     //                                            name:MPMoviePlayerLoadStateDidChangeNotification
      //                                         object:moviePlayer];
    
    moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    
    
    //moviePlayer.backgroundColor = [UIColor blackColor];
    
    moviePlayer.view.frame = CGRectMake(0, 0, 320, 200);
    
    [self.view addSubview:moviePlayer.view];
    [moviePlayer play];
    
}

-(void)moviePlayBackDidFinish:(NSNotification*)notification  {
    
    
}

@end
