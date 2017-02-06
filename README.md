# SwiftDIHLP

The high-level policy module for the [`SwiftDI`](https://github.com/alexbasson/SwiftDI) project, containing all the business logic for the various projects making up `SwiftDI`.

## Notes about Cocoapods vs. Swift Package Manager

The project uses [Quick](https://github.com/Quick/Quick) and [Nimble](https://github.com/Quick/Nimble) for Rspec-style behavioral unit testing. As of this writing, Quick and Nimble offer only experimental support for the Swift Package Manager, so they are included here via Cocoapods. As such, `swift build` does not import Quick and Nimble, and the project does not build using the Swift Package Manager.

This has some inconvenient consequences. In the long-term, it is hoped that Quick and Nimble will receive official support for SwiftPM, at which point `SwiftDIHLP` can move to including Quick and Nimble via SwiftPM rather than via Cocoapods.

## Installation

- If you haven't installed `SwiftDIHLP` as part of `SwiftDI`, clone it to your local machine:

    ```bash
    $ git clone https://github.com/alexbasson/SwiftDIHLP.git
    $ cd SwiftDIHLP
    ```

- Generate the `.xcodeproj`:

    ```bash
    $ swift package generate-xcodeproj
    ```

- Install the Cocoapods dependencies (this assumes you've already installed [the Cocoapods gem](https://cocoapods.org)):

    ```bash
    $ pod install
    ```

- Open `SwiftDIHLP.xcoworkspace` (**not** `SwiftDIHLP.xcodeproj`) in Xcode.

## Building

In Xcode, `Cmd-B` builds the project.

Using `swift build` from the command line fails to build the project due to the fact that Quick and Nimble are not imported via the Swift Package Manager.

## Testing

In Xcode, `Cmd-U` runs the tests.

`$ swift test` fails to test the app via the Swift Package Manager for the same reasons outline above in the Building section.
