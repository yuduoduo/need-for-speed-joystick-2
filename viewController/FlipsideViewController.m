#import "FlipsideViewController.h"
#import "MainViewController.h"
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>
#import "DefineComm.h"
@implementation FlipsideViewController

@synthesize acceleSwitch,soundSwitch;
@synthesize inputSocket;
@synthesize inputPort;

@synthesize numberPadShowing, dot;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self AddLables];
    self.view.backgroundColor = [UIColor clearColor];
    inputSocket.backgroundColor = [UIColor darkGrayColor];
    inputPort.backgroundColor = [UIColor darkGrayColor];
//    internetConnectionStatusField.backgroundColor = [UIColor darkGrayColor];
//    localWiFiConnectionStatusField.backgroundColor = [UIColor darkGrayColor];
    
    inputSocket.layer.cornerRadius=8.0f;
    inputSocket.layer.masksToBounds=YES;
    
    inputPort.layer.cornerRadius=8.0f;
    inputPort.layer.masksToBounds=YES;
    
//    internetConnectionStatusField.layer.cornerRadius=8.0f;
//    internetConnectionStatusField.layer.masksToBounds=YES;
//    
//    localWiFiConnectionStatusField.layer.cornerRadius=8.0f;
//    localWiFiConnectionStatusField.layer.masksToBounds=YES;
    
	[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];

	internetReach = [[Reachability reachabilityForInternetConnection] retain];
	[internetReach startNotifer];
	[self updateInterfaceWithReachability: internetReach];
	
    wifiReach = [[Reachability reachabilityForLocalWiFi] retain];
	[wifiReach startNotifer];
	[self updateInterfaceWithReachability: wifiReach];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	//whether is open
	if([defaults objectForKey:kIPadressKey] != nil)
	{
		
		inputSocket.text = [defaults objectForKey:kIPadressKey];
	}else
	{
		inputSocket.text = @"192.168.1.3";
	}
	
	//port
	if([defaults objectForKey:kPortKey] != nil)
	{
		
		inputPort.text = [defaults objectForKey:kPortKey];
	}else
	{
		inputPort.text = @"1000";
	}
    
    
}

-(void)AddLables
{


    [self AddStringToLable:NSLocalizedString(@"Auto search for services", 
                                             @"Auto search for services") 
                         x:40
                         y:30 
                     width:240
                    height:40
                     color:[UIColor colorWithRed:117.0f/255.0f green:117.0f/255.0f blue:117.0f/255.0f alpha:1.0]];
    [self AddStringToLable:NSLocalizedString(@"or enter your computer's IP & Port:", 
                                             @"or enter your computer's IP & Port:") 
                         x:40
                         y:60 
                     width:240
                    height:40
     color:[UIColor colorWithRed:117.0f/255.0f green:117.0f/255.0f blue:117.0f/255.0f alpha:1.0]];
    [self AddStringToLable:NSLocalizedString(@"Server IP", 
                                             @"Server IP") 
                         x:40
                         y:103 
                     width:240
                    height:40
     color:[UIColor whiteColor]];
    [self AddStringToLable:NSLocalizedString(@"Port", 
                                             @"Port") 
                         x:40
                         y:145 
                     width:240
                    height:40
     color:[UIColor whiteColor]];
    [self AddStringToLable:NSLocalizedString(@"Status", 
                                             @"Status") 
                         x:40
                         y:186 
                     width:240
                    height:40
     color:[UIColor colorWithRed:117.0f/255.0f green:117.0f/255.0f blue:117.0f/255.0f alpha:1.0]];
    [self AddStringToLable:NSLocalizedString(@"Options", 
                                             @"Options") 
                         x:40
                         y:314 
                     width:240
                    height:40
     color:[UIColor colorWithRed:117.0f/255.0f green:117.0f/255.0f blue:117.0f/255.0f alpha:1.0]];
    [self AddStringToLable:NSLocalizedString(@"Sound", 
                                             @"Sound") 
                         x:40
                         y:356 
                     width:240
                    height:40
     color:[UIColor whiteColor]];
    [self AddStringToLable:NSLocalizedString(@"Accelerometer", 
                                             @"Accelerometer") 
                         x:40
                         y:397 
                     width:240
                    height:40
     color:[UIColor whiteColor]];
    [self AddStringToLable:NSLocalizedString(@"Support", 
                                             @"Support") 
                         x:40
                         y:443 
                     width:240
                    height:40
                     color:[UIColor colorWithRed:117.0f/255.0f green:117.0f/255.0f blue:117.0f/255.0f alpha:1.0]];
}
-(void)AddStringToLable:(NSString*)text x:(int)x y:(int)y width:(int)width height:(int)height color:(UIColor*)color
{
    UILabel *myLable;
    myLable=[[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [myLable setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15.0]];
    [myLable setTextColor:color];
    [myLable setNumberOfLines:0];
    [myLable setBackgroundColor:[UIColor clearColor]];
    
    
//    UIFont *font = [UIFont fontWithName:@"Helvetica" size:15.0];
//    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(175.0f, 2000.0f) lineBreakMode:UILineBreakModeWordWrap];
//    CGRect rect=myLable.frame;
//    rect.size=size;
//    [myLable setFrame:rect];
    [myLable setText:text];
    [self.view addSubview:myLable];
    [myLable release];
}
- (IBAction)soundSwitchClick:(id)sender
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults setBool:soundSwitch.on forKey:kIPsoundKey];
}
- (void)viewWillDisappear:(BOOL)animated
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

	[defaults setObject:inputSocket.text forKey:kIPadressKey];
	[defaults setBool:acceleSwitch.on forKey:kAcceleKey];
    [defaults setBool:!soundSwitch.on forKey:kIPsoundKey];

	[defaults setObject:inputPort.text forKey:kPortKey];
	[defaults synchronize];
	
	
	if (self.numberPadShowing) {
		[self.dot removeFromSuperview];
	}	
	
	// Set numberPadShowing back to NO, so that if you show another keyboard, it will not be re-added.
	self.numberPadShowing = NO;

	//clear notification
	/*
	[[NSNotificationCenter defaultCenter] removeObserver:self	 
													name:UIKeyboardWillShowNotification
												  object:nil];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self	 
													name:@"DecimalPressed"
												  object:nil];
	*/
    [super viewWillDisappear:animated];
	}


- (void) configureTextField: (UITextField*) textField imageView: (UIImageView*) imageView reachability: (Reachability*) curReach
{
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    BOOL connectionRequired= [curReach connectionRequired];
    NSString* statusString= @"";
    switch (netStatus)
    {
        case NotReachable:
        {
            statusString = @"Access Not Available";
            imageView.image = [UIImage imageNamed: @"stop-32.png"] ;
            //Minor interface detail- connectionRequired may return yes, even when the host is unreachable.  We cover that up here...
            connectionRequired= NO;  
            break;
        }
            
        case ReachableViaWWAN:
        {
            statusString = @"Reachable WWAN";
            imageView.image = [UIImage imageNamed: @"WWAN5.png"];
            break;
        }
        case ReachableViaWiFi:
        {
			statusString= @"Reachable WiFi";
            imageView.image = [UIImage imageNamed: @"Airport.png"];
            break;
		}
    }
    if(connectionRequired)
    {
        statusString= [NSString stringWithFormat: @"%@, Connection Required", statusString];
    }
    textField.text= statusString;
}

- (void) updateInterfaceWithReachability: (Reachability*) curReach
{
	if(curReach == internetReach)
	{	
		[self configureTextField: internetConnectionStatusField imageView: internetConnectionIcon reachability: curReach];
	}
	if(curReach == wifiReach)
	{	
		[self configureTextField: localWiFiConnectionStatusField imageView: localWiFiConnectionIcon reachability: curReach];
	}
	
}

//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self updateInterfaceWithReachability: curReach];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)backgroundClick:(id)sender
{	
	[inputSocket resignFirstResponder];
	[inputPort resignFirstResponder];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[internetConnectionIcon release];
    [internetConnectionStatusField release];
    [localWiFiConnectionIcon release];
    [localWiFiConnectionStatusField release];
    
    [soundSwitch release];
	[acceleSwitch release];
	[inputSocket release];
	[inputPort release];
	[super dealloc];
}

////////////////////////////////
////

//add dot
//add dot


// This function is called each time the keyboard is going to be shown
- (void)keyboardWillShow:(NSNotification *)note {
    
	// Just used to reference windows of our application while we iterate though them
	UIWindow* tempWindow;
	
	// Because we cant get access to the UIKeyboard throught the SDK we will just use UIView. 
	// UIKeyboard is a subclass of UIView anyways
	UIView* keyboard;
	
	// Check each window in our application
	for(int c = 0; c < [[[UIApplication sharedApplication] windows] count]; c ++)
	{
		// Get a reference of the current window
		tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:c];
		
		// Loop through all views in the current window
		for(int i = 0; i < [tempWindow.subviews count]; i++)
		{
			// Get a reference to the current view
			keyboard = [tempWindow.subviews objectAtIndex:i];
			
			// From all the apps i have made, they keyboard view description always starts with <UIKeyboard so I did the following
		//	if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
			if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES || [[keyboard description] hasPrefix:@"<UIView"] == YES) 
			{
				// Only add the Decimal Button if the Keyboard showing is a number pad. (Set Manually through a BOOL)
				if (numberPadShowing) {
					
					// Set the Button Type.
					dot = [UIButton buttonWithType:UIButtonTypeCustom];
					
					// Position the button - I found these numbers align fine (0, 0 = top left of keyboard)
					dot.frame = CGRectMake(0, 363, 106, 53);
				
					// Add images to our button so that it looks just like a native UI Element.
					[dot setImage:[UIImage imageNamed:@"dotNormal.png"] forState:UIControlStateNormal];
					[dot setImage:[UIImage imageNamed:@"dotHighlighted.png"] forState:UIControlStateHighlighted];
					
					//Add the button to the keyboard
					[keyboard addSubview:dot];
					[keyboard bringSubviewToFront:dot];
					// When the decimal button is pressed, we send a message to ourself (the AppDelegate) which will then post a notification that will then append a decimal in the UITextField in the Appropriate View Controller.
					[dot addTarget:self action:@selector(sendDecimal:)  forControlEvents:UIControlEventTouchUpInside];
					
					return;					
				}
			}
		}
	}
}

- (void)sendDecimal:(id)sender {
	// Post a Notification that the Decimal Key was Pressed.
	[[NSNotificationCenter defaultCenter] postNotificationName:@"DecimalPressed" object:nil];	
}

//*
- (void)viewWillAppear:(BOOL)animated {
	// Register to Recieve notifications of the Decimal Key Being Pressed and when it is pressed do the corresponding addDecimal action.
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addDecimal:) name:@"DecimalPressed" object:nil];
	
	// Set numberPadShowing to Yes so that the Decimal Button is Added.
	self.numberPadShowing = YES;
	
	// Make the Background Pretty.
	//self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	// Make the Number Pad Pop Up.
	//[inputSocket becomeFirstResponder];
    [super viewWillAppear:animated]; 
}


- (void)addDecimal:(NSNotification *)notification {
	// Apend the Decimal to the TextField.
	inputSocket.text = [inputSocket.text stringByAppendingString:@"."];
}

@end