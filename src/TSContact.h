#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#endif
#import <AddressBook/AddressBook.h>

#define TS_CONTACT_VERSION @"0.1"

@interface TSContact : NSObject {
    ABAddressBookRef _addressBook;
    ABRecordID _recordId;
    ABRecordRef _recordRef;
    NSString *_fullName;
}
- (id)initWithId:(ABRecordID)recordId;
- (id)initWithRef:(ABRecordRef)recordRef;
- (NSString *)fullName;
@end
