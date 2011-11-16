//
//  ViewController.m
//  Accountant
//
//  Created by Jeffrey Lim on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation ViewController

@synthesize runningTotals;
@synthesize terminal;
@synthesize ticker;


- (void)alert:(NSString*)text {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:text delegate:self cancelButtonTitle:@"OK"    otherButtonTitles:nil] ;
    [alert show];
    [alert release];
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)refreshRunningTotals {
    runningTotals.text = @"";
    for (int i=[ticker count]-1; i>=0; i--) {
        NSDictionary *entry = [ticker objectAtIndex:i];
        [self addOnTop:entry];
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

    
    
    int cornerX = 20;
    int cornerY = 150;
    int size = 130;
    int margin = 15;
    float fontsize = 100.0;
    

    
    terminal = [[UITextView alloc] initWithFrame:CGRectMake(cornerX, cornerY-130, size*5+margin*5, 100)];
    terminal.text = @"";
    terminal.font = [terminal.font fontWithSize:80.0];
    terminal.textAlignment = UITextAlignmentRight;
    terminal.layer.borderWidth = 5.0f;
    terminal.layer.borderColor = [[UIColor blackColor] CGColor];
    terminal.editable = NO;
    [self.view addSubview:terminal];
    [terminal release];
    
    NSDate *now = [[NSDate alloc] init];
    ticker = [[NSMutableArray alloc] initWithObjects:([[NSDictionary alloc] initWithObjectsAndKeys:@"+",@"sign",  [[NSNumber alloc] initWithFloat:0.0 ],@"change", [[NSNumber alloc] initWithFloat:0.0 ],@"total", now,@"date", nil]), nil];
    //[self alert:now.description];
    
    
    
    runningTotals = [[UITextView alloc] initWithFrame:CGRectMake(cornerX, cornerY+4*size+4*margin, size*5+margin*5, 250)];
    runningTotals.font = [runningTotals.font fontWithSize:20.0];
    runningTotals.editable = NO;
    
    runningTotals.layer.borderWidth = 1.0f;
    runningTotals.layer.borderColor = [[UIColor blackColor] CGColor];
    [self refreshRunningTotals];
    [self.view addSubview:runningTotals];
    [runningTotals release];
    
    
    UIButton *button7 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button7.frame = CGRectMake(cornerX, cornerY, size, size);
    UIButton *button8 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button8.frame = CGRectMake(cornerX+size+margin, cornerY, size, size);
    UIButton *button9 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button9.frame = CGRectMake(cornerX+2*size+2*margin, cornerY, size, size);
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button4.frame = CGRectMake(cornerX, cornerY+size+margin, size, size);
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button5.frame = CGRectMake(cornerX+size+margin, cornerY+size+margin, size, size);
    UIButton *button6 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button6.frame = CGRectMake(cornerX+2*size+2*margin, cornerY+size+margin, size, size);
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.frame = CGRectMake(cornerX, cornerY+2*size+2*margin, size, size);
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame = CGRectMake(cornerX+size+margin, cornerY+2*size+2*margin, size, size);
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button3.frame = CGRectMake(cornerX+2*size+2*margin, cornerY+2*size+2*margin, size, size);
    
    UIButton *button0 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button0.frame = CGRectMake(cornerX, cornerY+3*size+3*margin, 2*size+margin, size);
    UIButton *buttonP = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonP.frame = CGRectMake(cornerX+2*size+2*margin, cornerY+3*size+3*margin, size, size);
    
    
    NSArray* numberButtons = [NSArray arrayWithObjects:button0, button1, button2, button3, button4, button5, button6, button7, button8, button9, buttonP, nil];
    
    for (int i=0; i<=10; i++) {
        UIButton* button = [numberButtons objectAtIndex:i];
        if (i != 10) {
            [button setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
        }
        else {
            [button setTitle:@"." forState:UIControlStateNormal];
        }
        button.titleLabel.font = [button.titleLabel.font fontWithSize:fontsize];
        [button addTarget:self action:@selector(numberButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addButton.frame = CGRectMake(cornerX+3*size+4*margin, cornerY+3*size+3*margin, size*2+margin, size);
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    addButton.titleLabel.font = [addButton.titleLabel.font fontWithSize:fontsize];
    [addButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];

    
    UIButton *subButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    subButton.frame = CGRectMake(cornerX+3*size+4*margin, cornerY+2*size+2*margin, size*2+margin, size);
    [subButton setTitle:@"-" forState:UIControlStateNormal];
    subButton.titleLabel.font = [subButton.titleLabel.font fontWithSize:fontsize];
    [subButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subButton];
    
    UIButton *delButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    delButton.frame = CGRectMake(cornerX+3*size+4*margin, cornerY+size+margin, size*2+margin, size);
    [delButton setTitle:@"del. prev." forState:UIControlStateNormal];
    delButton.titleLabel.font = [delButton.titleLabel.font fontWithSize:fontsize*0.5];
    [delButton addTarget:self action:@selector(delButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delButton];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(cornerX+3*size+4*margin, cornerY, size, size);
    [backButton setTitle:@"<<" forState:UIControlStateNormal];
    backButton.titleLabel.font = [addButton.titleLabel.font fontWithSize:fontsize];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    clearButton.frame = CGRectMake(cornerX+4*size+5*margin, cornerY, size, size);
    [clearButton setTitle:@"C" forState:UIControlStateNormal];
    clearButton.titleLabel.font = [clearButton.titleLabel.font fontWithSize:fontsize];
    [clearButton addTarget:self action:@selector(clearButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearButton];


    

    
}


- (IBAction) numberButtonClicked:(id) sender {
    NSString *text = ((UIButton*)sender).titleLabel.text;
    NSRange range = [self.terminal.text rangeOfString:@"." options:NSCaseInsensitiveSearch];
    //[self alert:self.terminal.text];
    if ([text isEqualToString:@"0"] && [self.terminal.text isEqualToString:@""]) {
        //do nothing
    }
    else if ([text isEqualToString:@"."] && range.location != NSNotFound){
        //do nothing
    }
    else {
        self.terminal.text = [self.terminal.text stringByAppendingString:text];
    }
}

- (IBAction) backButtonClicked:(id) sender {
    if ([self.terminal.text isEqualToString:@""]) {
        //do nothing
    }
    else {
        self.terminal.text = [self.terminal.text substringToIndex:[self.terminal.text length]-1];
    }
}

- (IBAction) clearButtonClicked:(id) sender {
    self.terminal.text = @"";
}

- (IBAction) delButtonClicked:(id) sender {
    if ([ticker count] > 1) {
        [ticker removeLastObject];
        //[self refreshRunningTotals];
        NSRange range = [runningTotals.text rangeOfString:@"\n"];
        if (range.location != NSNotFound) {
            runningTotals.text = [runningTotals.text substringFromIndex:range.location+1];
        }
    }
}


- (IBAction) addButtonClicked:(id) sender {
    NSString *text = ((UIButton*)sender).titleLabel.text;
    NSDate *now = [[NSDate alloc] init];
    float oldTotal = [[[ticker objectAtIndex:[ticker count]-1] objectForKey:@"total"] floatValue];
    //[self alert:[NSString stringWithFormat:@"%f",oldTotal]];
    float change = [self.terminal.text floatValue];
    if ([text isEqualToString:@"-"]) {
        change = -1*change;
    }
    float newTotal = oldTotal + change;
    //if() {
    //    = [self.terminal.text floatValue]
    //}
    NSDictionary *newEntry = [[NSDictionary alloc] initWithObjectsAndKeys:text,@"sign",  [[NSNumber alloc] initWithFloat:[self.terminal.text floatValue] ],@"change", [[NSNumber alloc] initWithFloat:newTotal ],@"total", now,@"date", nil];
    [ticker addObject:newEntry];
    //self.terminal.text = @"";
    [self addOnTop:newEntry];
    //[self refreshRunningTotals];
}


- (void)addOnTop:(NSDictionary*)entry {
    NSString* newLine = @"";
    newLine = [newLine stringByAppendingString:[entry objectForKey:@"sign"]];
    newLine = [newLine stringByAppendingString:((NSNumber*)[entry objectForKey:@"change"]).description];
    newLine = [newLine stringByAppendingString:@"      -->     $"];
    newLine = [newLine stringByAppendingString:((NSNumber*)[entry objectForKey:@"total"]).description];
    newLine = [newLine stringByAppendingString:@"             "];
    newLine = [newLine stringByAppendingString:((NSDate*)[entry objectForKey:@"date"]).description];
    newLine = [newLine stringByAppendingString:@"\n"];
    runningTotals.text = [newLine stringByAppendingString:runningTotals.text];
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    [runningTotals release];
    [terminal release];
    [ticker release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
