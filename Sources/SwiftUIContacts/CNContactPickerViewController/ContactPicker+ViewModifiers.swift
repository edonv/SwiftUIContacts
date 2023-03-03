//
//  ContactPicker+ViewModifiers.swift
//  
//
//  Created by Edon Valdman on 3/3/23.
//

import SwiftUI
import Contacts

extension View where Self == ContactPicker {
    /// Adds a predicate to determine the contact selectability in the list of contacts.
    ///
    /// You can set a value for this property to determine which contact should become selectable, such as `emailAddresses.@count > 0` to enable all the contacts that have an email address to become selectable. If no predicate is set for this property, all contacts become selectable.
    ///
    /// To learn about predicate syntax, see [NSPredicate](https://developer.apple.com/documentation/foundation/nspredicate).
    public func filterEnabledContacts(with predicate: NSPredicate) -> ContactPicker {
        var newView = self
        newView.setPredicateForEnablingContact(predicate)
        return newView
    }
    
    /// Adds a predicate to control the return of the selected contact.
    ///
    /// This property determines whether a selected contact should be returned (when the predicate evaluates to TRUE), or a default action for the property should be performed (when the predicate evaluates to FALSE). By default the contact picker view controller displays the contact’s detail card when a contact is selected.
    ///
    /// To learn about predicate syntax, see [NSPredicate](https://developer.apple.com/documentation/foundation/nspredicate).
    public func filterSelectableContacts(with predicate: NSPredicate) -> ContactPicker {
        var newView = self
        newView.setPredicateForSelectionOfContact(predicate)
        return newView
    }
    
    /// Adds a predicate to control the properties of the selected contact.
    ///
    /// This property determines whether a selected contact should be returned (when the predicate evaluates to TRUE), or a default action for the property should be performed (when the predicate evaluates to FALSE). By default the contact picker view controller returns the first selected property of the contact. This predicate is evaluated on the [CNContactProperty](https://developer.apple.com/documentation/contacts/cncontactproperty) property that is being selected, such as `(key == 'emailAddresses') AND (value LIKE '*@apple.com')` to return email address of the contact if the address contains the string “@apple.com”.
    ///
    /// To learn about predicate syntax, see [NSPredicate](https://developer.apple.com/documentation/foundation/nspredicate).
    public func filterSelectableProperties(with predicate: NSPredicate) -> ContactPicker {
        var newView = self
        newView.setPredicateForSelectionOfProperty(predicate)
        return newView
    }
}
