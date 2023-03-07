//
//  ContactView.swift
//  
//
//  Created by Edon Valdman on 3/6/23.
//

#if os(iOS) || targetEnvironment(macCatalyst)

import SwiftUI
import ContactsUI
import Contacts

// TODO: figure out CNContactViewController's usage on a Mac

/// A view that displays a new, unknown, or existing contact.
///
/// Present a `ContactView` when you want to display information about one of the user's contacts. At creation time, you specify the type of contact you want to display: new, unknown, or existing.
///
/// A `SwiftUI` wrapper for [CNContactViewController](https://developer.apple.com/documentation/contactsui/cncontactviewcontroller).
public struct ContactView: View {
    public typealias PropertySelectionHandler = (_ property: CNContactProperty) -> Bool
    public typealias CompletionHandler = (_ contact: CNContact?) -> Void
    
    enum ContactMode {
        case existing(contact: CNContact)
        case unknown(contact: CNContact)
        case new(contact: CNContact?)
    }
    
    @available(iOS 13, macCatalyst 13.1, *)
    public var configuration: Configuration
    
    private var mode: ContactMode
    
    private var propertySelectionAction: PropertySelectionHandler?
    private var completionHandler: CompletionHandler?
    private var allowsEditing: Bool = true
    private var allowsActions: Bool = true
    private var shouldShowLinkedContacts: Bool = false
    
    // MARK: Initializers
    
    /// Initializes a view for an existing contact.
    ///
    /// This initializes the customized behavior and appearance of `ContactView` for an existing contact.
    /// - Parameter contact: The existing contact.
    public init(for contact: CNContact, configuration: Configuration) {
        mode = .existing(contact: contact)
        self.configuration = configuration
    }
    
    /// Initializes a view for an unknown contact.
    ///
    /// This initializes the customized behavior and appearance of `ContactView` for an unknown contact.
    /// - Parameter contact: The contact to be displayed.
    public init(forUnknownContact contact: CNContact, configuration: Configuration) {
        mode = .unknown(contact: contact)
        self.configuration = configuration
    }
    
    /// Initializes a view for a new contact.
    ///
    /// This initializes the customized behavior and appearance of `ContactView` for a new contact.
    /// - Parameter contact: The contact to be displayed.
    public init(forNewContact contact: CNContact?, configuration: Configuration) {
        mode = .new(contact: contact)
        self.configuration = configuration
    }
    
    // MARK: Internal Property Setters
    
    internal mutating func setPropertySelectionAction(_ action: PropertySelectionHandler?) {
        self.propertySelectionAction = action
    }
    
    internal mutating func setCompletionHandler(_ action: CompletionHandler?) {
        self.completionHandler = action
    }
    
    internal mutating func setAllowsEditing(_ allows: Bool) {
        self.allowsEditing = allows
    }
    
    internal mutating func setAllowsActions(_ allows: Bool) {
        self.allowsActions = allows
    }
    
    internal mutating func setShouldShowLinkedContacts(_ shouldShow: Bool) {
        self.shouldShowLinkedContacts = shouldShow
    }
}

extension ContactView {
    @available(iOS 13, macCatalyst 13.1, *)
    public struct Configuration {
        // MARK: Displaying Contact Properties
        
        /// The name to use if the contact has no display name.
        public var alternativeName: String?
        
        /// The message displayed under the name of the contact.
        public var message: String?
        
        /// The contact property keys to display.
        ///
        /// If this property is not set, the view controller displays all properties.
        public var displayedPropertyKeys: [ContactsConstant]?
        
        // MARK: Configuring the Contact's Relationships
        
        /// The group in which to add a new contact.
        ///
        /// If you do not set this property, the view adds a new contact to the default group.
        public var parentGroup: CNGroup?
        
        /// The container in which to add a new contact.
        ///
        /// If you do not set this property, the view adds a new contact to the default container.
        public var parentContainer: CNContainer?
        
        // MARK: Contact Store
        
        /// The contact store from which the contact was fetched or to which it will be saved.
        ///
        /// If not this property is not set, than adding the contact to the user's contacts is disabled.
        public var contactStore: CNContactStore?
    }
}

// MARK: - UIViewControllerRepresentable / iOS

@available(iOS 13, macCatalyst 13.1, *)
extension ContactView: UIViewControllerRepresentable {
    public func makeUIViewController(context: Context) -> CNContactViewController {
        let vc: CNContactViewController
        switch mode {
        case .existing(let contact):
            vc = .init(for: contact)
        case .unknown(let contact):
            vc = .init(forUnknownContact: contact)
        case .new(let contact):
            vc = .init(forNewContact: contact)
        }
        
        vc.delegate = context.coordinator
        return vc
    }
    
    public func updateUIViewController(_ uiViewController: CNContactViewController, context: Context) {
        
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension ContactView {
    @available(iOS 13, macCatalyst 13.1, *)
    public class Coordinator: NSObject, CNContactViewControllerDelegate {
        internal var parent: ContactView
        
        internal init(_ parent: ContactView) {
            self.parent = parent
        }
        
        public func contactViewController(_ viewController: CNContactViewController, shouldPerformDefaultActionFor property: CNContactProperty) -> Bool {
            parent.propertySelectionAction?(property) ?? true
        }
        
        public func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
            parent.completionHandler?(contact)
            viewController.dismiss(animated: true)
        }
    }
}

#endif
