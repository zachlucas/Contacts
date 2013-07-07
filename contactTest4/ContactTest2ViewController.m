//
//  ContactTest2ViewController.m
//  contactTest4
//
//  Created by Lab Admin on 5/9/13.
//  Copyright (c) 2013 Lab Admin. All rights reserved.
//

#import "ContactTest2ViewController.h"

@interface ContactTest2ViewController ()

@end


@implementation ContactTest2ViewController

@synthesize tableYay;

NSArray* bigA= nil;
NSArray* biggerDateA = nil;
NSArray* bigPhone = nil;
//NSMutableArray* bigDateA;



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    NSMutableArray* bigDateA;
    bigDateA = [[NSMutableArray alloc] init];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    
    NSMutableDictionary* mutDict = [NSMutableDictionary dictionary];
    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    
    NSArray* allPeople = (NSArray*) ABAddressBookCopyArrayOfAllPeople( addressBook );
    int count = 0;
    for( id aPerson in allPeople ) {
        NSString* firstName = (NSString*) ABRecordCopyValue( aPerson, kABPersonFirstNameProperty );
        NSString* lastName = (NSString* ) ABRecordCopyValue( aPerson, kABPersonLastNameProperty );
        NSDate* createDate = (NSDate*) ABRecordCopyValue( aPerson, kABPersonCreationDateProperty );
        //NSString* phoneNumber = (NSString*) ABRecordCopyValue(aPerson, kABPersonPhoneProperty);
        //NSMutableString *totalName = appendString(firstName);
        NSString *newName = @"";
        newName = [newName stringByAppendingString:firstName];
        newName = [newName stringByAppendingString:@" "];
        newName = [newName stringByAppendingString:lastName];
        
        //NSLog(newName);
        //NSString* formattedDate = [dateFormatter stringFromDate:createDate];
        [mutDict setObject:(createDate) forKey:(newName)];
        
        //NSLog( @"%@ %@ created %@", firstName, lastName, formattedDate );
        /*
        NSMutableArray *phoneNumbers = [[[NSMutableArray alloc] init] autorelease];
        ABMultiValueRef multiPhones = ABRecordCopyValue(aPerson,kABPersonPhoneProperty);
       
        CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(multiPhones,count);
        NSString *phoneNumber = (NSString *) phoneNumberRef;
            
       [phoneNumbers addObject:phoneNumber];
       
        
        bigPhone = phoneNumbers;
       */ 
        count++;
        
        
        [firstName release];
        [lastName release];
        [createDate release];
    }
    
    
    
    //NSLog(@"%@",bigPhone);
    
    //NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"Date"
    //                                                           ascending:YES];
    //[array sortUsingDescriptors:[NSArray arrayWithObject:descriptor]];
    
    NSArray *sortedKeys = [mutDict  keysSortedByValueUsingComparator:^NSComparisonResult(NSDate *obj1, NSDate *obj2)
                           {
                               return [obj2 compare:obj1];
                           }];
    
    //NSLog(@"%@",sortedKeys);

    bigA = sortedKeys;
    //NSLog(@"%@",sortedKeys);
    for (int i =0;i<[sortedKeys count];i++){
        [bigDateA addObject:[mutDict objectForKey:(sortedKeys[i])]];
        //[bigDateA addObject:(@"ASDSD")];
    }
    //bigDateA = [mutDict objectForKey:(@"AAA BBB")];
    
    //NSLog(@"%@",bigDateA);
    biggerDateA = bigDateA;
    //NSLog(@"%@",biggerDateA);
    [allPeople release];
    [dateFormatter release];
    CFRelease(addressBook);
    
    
	// Do any additional setup after loading the view, typically from a nib.
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [bigA count];
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *str = cell.detailTextLabel.text;
    
    //NSLog(@"%@",str);
    NSString* str2 = [@"" stringByAppendingString:str];
    
    //UIAlertView *messageAlert = [[UIAlertView alloc]
      //                           initWithTitle:@"Row Selected" message:str2 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    
    NSString* date1 = [str2 stringByReplacingOccurrencesOfString:(@"Created on: ") withString:(@"")];
    UIAlertView *messageAlert = [[UIAlertView alloc] initWithTitle:@"Row Selected" message:date1 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:date1];
    //*********
    // Searching addressbook for contact by date
    /*ABAddressBookRef addressBook = ABAddressBookCreate();
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
    
    for (CFIndex personIndex = 0; personIndex < nPeople; personIndex++){
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, personIndex);
        CFStringRef name = ABRecordCopyCompositeName(person);
        ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        for (CFIndex phoneIndex = 0; phoneIndex < ABMultiValueGetCount(phones);phoneIndex++){
            //NSString* aLabel = (NSString*) ABMultiValueCopyLabelAtIndex(phones, phoneIndex);
            NSString* aLabel = @"Forest";
            NSLog(@"%@",(NSString*)kABPersonLastNameProperty);
            //if ([aLabel isEqualToString:(NSString*)kABPersonPhoneMainLabel]){
             //   NSLog(@"One match");
           // }
            
            
        }
        
    }*/
    
    
    
    [dateFormatter release];
    // Display Alert Message
    [messageAlert show];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    //cell.textLabel.text = [NSString stringWithFormat:@"row %i",[indexPath row]];
    /*int i;
    for (i =0; [bigA count]; i++)
    {
        cell.textLabel.text = [bigA objectAtIndex:(i)];
        return cell;
    }*/
    
    //NSUInteger row = [indexPath row];
    
    //NSLog(@"%@",[biggerDateA objectAtIndex:indexPath.row]);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    
    //Optionally for time zone converstions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    
    NSString* temp = [formatter stringFromDate:[biggerDateA objectAtIndex:indexPath.row]];
    
    //NSLog(@"%@",biggerDateA);
    temp = [@"Created on: " stringByAppendingString:temp];
    
    
    
    cell.textLabel.text = [bigA objectAtIndex:indexPath.row];
    //cell.detailTextLabel.text = [biggerDateA objectAtIndex:indexPath.row];
    //cell.detailTextLabel.text = @"Date Goes here";
    
    cell.detailTextLabel.text = temp;
    [bigA retain];
    //[biggerDateA retain];
    return cell;
}




- (void)dealloc {
    //[bigA release];
    [tableYay release];
    [super dealloc];
}
@end
