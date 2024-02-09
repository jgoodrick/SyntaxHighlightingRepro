Once you clone the repo, if you just run tuist install and tuist generate, you'll see that the syntax highlighting is working just fine.

Then, if you run tuist cache ComposableArchitecture, followed by tuist generate, you'll see that the syntax highlighting for the @Reducer and @ObservableState macros is no longer working.

Finally, if you remove the platforms argument from Tuist's Package.swift file, you get the highlighting back with your next tuist generate. So the platforms argument in the PackageSettings seems to be the thing breaking it, which is odd, because in the fixture/app_with_spm_dependencies, it defines both platforms: [.iOS, .watchOS] and has no issue with the highlighting. Granted, the rest of the package settings are different than this minimal repro.
