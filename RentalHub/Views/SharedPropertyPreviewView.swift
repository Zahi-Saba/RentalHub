//
//  SharedPropertyPreviewView.swift
//  RentalHub
//
//  Created by Zahi Saba on 3/10/2026.
//

import SwiftUI
import LinkPresentation

struct SharedPropertyPreviewView: View {

    @State private var sharedLinks: [String] = []

    var body: some View {

        ScrollView {

            VStack(spacing: 20) {

                if sharedLinks.isEmpty {

                    Text(
                        "No rental properties have been shared yet."
                    )

                } else {

                    ForEach(
                        sharedLinks,
                        id: \.self
                    ) { link in

                        SharedPropertyCard(
                            link: link
                        )
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Shared Properties")
        .onAppear {

            sharedLinks =
                SharedRentalLinkData.loadLinks()
        }
    }
}

struct SharedPropertyCard: View {

    let link: String

    @State private var metadata: LPLinkMetadata?

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            if let metadata = metadata {

                LinkPreview(
                    metadata: metadata
                )
                .frame(
                    maxWidth: .infinity,
                    minHeight: 300
                )

            } else {

                ProgressView(
                    "Loading property..."
                )
            }
        }
        .onAppear {
            loadPreview()
        }
    }

    private func loadPreview() {

        if let url = URL(
            string: link
        ) {

            let provider =
                LPMetadataProvider()

            provider.startFetchingMetadata(
                for: url
            ) { metadata, error in

                if let metadata = metadata {

                    DispatchQueue.main.async {

                        self.metadata =
                            metadata
                    }
                }
            }
        }
    }
}

struct LinkPreview: UIViewRepresentable {

    let metadata: LPLinkMetadata

    func makeUIView(
        context: Context
    ) -> LPLinkView {

        let linkView = LPLinkView()

        linkView.metadata = metadata

        return linkView
    }

    func updateUIView(
        _ uiView: LPLinkView,
        context: Context
    ) {

        uiView.metadata = metadata
    }
}
