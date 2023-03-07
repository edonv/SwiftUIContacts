//
//  ContactView+ViewModifiers.swift
//  
//
//  Created by Edon Valdman on 3/7/23.
//

#if os(iOS) || targetEnvironment(macCatalyst)

import SwiftUI
import Contacts

@available(iOS 13, macCatalyst 13.1, *)
extension View where Self == ContactView {
    /// Set an action to be called when the user selects a property.
    ///
    /// The closure contains 1 parameter, the `CNContactProperty` that is selected, and must return a `Bool`. Return `true` to call the default action performed for the property, otherwise return `false`.
    ///
    /// Set this to determine the resulting behavior when a property is selected. Return `false` if you do not want anything to be done or if you are handling the actions yourself.
    public func onPropertySelection(perform action: ContactView.PropertySelectionHandler? = nil) -> ContactView {
        var newView = self
        newView.setPropertySelectionAction(action)
        return newView
    }
    
    /// Sets an action to be called when the view is to be dismissed.
    ///
    /// The closure contains 1 parameter, a `CNContact?` that is the newly-created or existing contact being added.
    ///
    /// If creating a new contact, the new contact added to the contacts list is passed in `contact`. If adding to an existing contact, the existing contact is passed in `contact`.
    public func onCompletion(perform action: ContactView.CompletionHandler? = nil) -> ContactView {
        var newView = self
        newView.setCompletionHandler(action)
        return newView
    }
    
    /// Determines whether the user can edit the contact’s information.
    ///
    /// By default, this is set to `true`. All properties are visible when editing a contact.
    public func allowsEditing(_ allows: Bool = true) -> ContactView {
        var newView = self
        newView.setAllowsEditing(allows)
        return newView
    }
    
    /// Determines whether to display buttons for actions such as sending a text message or initiating a FaceTime call.
    ///
    /// By default, this is set to `true`.
    public func allowsActions(_ allows: Bool = true) -> ContactView {
        var newView = self
        newView.setAllowsActions(allows)
        return newView
    }
    
    /// Determines whether to display data from contacts that are linked to the contact being displayed.
    ///
    /// By default, this is set to `false`.
    public func shouldShowLinkedContacts(_ shouldShow: Bool = true) -> ContactView {
        var newView = self
        newView.setShouldShowLinkedContacts(shouldShow)
        return newView
    }
}

#endif
