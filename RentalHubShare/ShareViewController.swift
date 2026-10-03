//
//  ShareViewController.swift
//  RentalHubShare
//
//  Created by Zahi Saba on 3/10/2026.
//

import UIKit
import Social
import UniformTypeIdentifiers

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        return true
    }

    override func didSelectPost() {

        if let item = extensionContext?.inputItems.first
            as? NSExtensionItem {

            if let attachment = item.attachments?.first {

                if attachment.hasItemConformingToTypeIdentifier(
                    UTType.url.identifier
                ) {

                    attachment.loadItem(
                        forTypeIdentifier: UTType.url.identifier,
                        options: nil
                    ) { item, error in

                        if let url = item as? URL {

                            SharedRentalLinkData.saveLink(
                                url.absoluteString
                            )
                        }

                        self.extensionContext?
                            .completeRequest(
                                returningItems: nil
                            )
                    }

                    return
                }
            }
        }

        extensionContext?.completeRequest(
            returningItems: nil
        )
    }

    override func configurationItems() -> [Any]! {
        return []
    }
}
