# 🚨 AlertKit

![swift v5.3](https://img.shields.io/badge/swift-v5.3-orange.svg)
![platform iOS](https://img.shields.io/badge/platform-iOS-blue.svg)
![deployment target iOS 14](https://img.shields.io/badge/deployment%20target-iOS%2014-blueviolet)

**AlertKit** is a lightweight library which makes `SwiftUI` alert and action sheet presentation super easy to use.

## 💻 Installation
### 📦 Swift Package Manager
Using <a href="https://swift.org/package-manager/" rel="nofollow">Swift Package Manager</a>, add it as a Swift Package in Xcode 11.0 or later, `select File > Swift Packages > Add Package Dependency...` and add the repository URL:
```
https://github.com/rebeloper/AlertKit.git
```
### ✊ Manual Installation
Download and include the `AlertKit` folder and files in your codebase.

### 📲 Requirements
- iOS 14+
- Swift 5

## 👉 Import

Import `AlertKit` into your `View`

```
import AlertKit
```

## 🧳 Features

Here's the list of the awesome features `AlertKit` has:
- [X] prograatic way to show `Alert`s in SwiftUI
- [X] you don't have to add `Alert`s as view modifiers any more
- [X] supports `Action Sheet`s
- [X] blends in perfectly with all other SwiftUI functioanlity and principles

## 😤 The Problem

In `SwiftUI` alerts are added as view modifiers with a bit of help from `@State`:

```
struct ContentView: View {
    
    @State private var isSwiftUIAlertPresented = false
    
    var body: some View {
        VStack {
            
            Button("SwiftUI Alert") {
                isSwiftUIAlertPresented = true
            }.alert(isPresented: $isSwiftUIAlertPresented) {
                Alert(title: Text("SwiftUI Alert"))
            }
            
            Spacer()
        }
    }
```

This will get ugly really quickly if you're trying to add multiple `Alert`s on a view. Lots of `@State`s with `Alert`s scattered all around your view 🤭

With `AlertKit` you can invoke an `Alert` as simple as calling: 

```
alertManager.show(dismiss: .success(message: "AlertKit is awesome"))
```

## ⚙️ How to use

Using `AlertKit` is super simple:

1. create a `@StateObject` variable of `AlertManager()`
2. add the `.uses(_:)` view-modifier
3. show an alert 🤩

```
import AlertKit

struct ContentView: View {
    
    // 1.
    @StateObject var alertManager = AlertManager()
    
    var body: some View {
        VStack {
            Button("Show Dismiss Alert") {
                // 3.
                alertManager.show(dismiss: .success(message: "AlertKit is awesome"))
            }
        }
        .uses(alertManager) // 2.
    }
}

```

### 1️⃣ Dismiss Alert

There are two types of alerts in `SwiftUI`. The `Dismiss Alert` is one of them. It presents an alert with:
 - [X] title
 - [X] message
 - [X] **one** button (dismiss)
 
 ```
 alertManager.show(dismiss: .success(message: "AlertKit is awesome"))
 ```
 
 `AlertKit` comes with some predifined helpers to make your life easier. In all of the above the only variable is the `meassage`. `Title` and `button(s)` are predifined if that is the case. Of course you may override any or all of them if you wish. 
 **Important:** Make sure that you use the `dismiss` ones with the `dismiss` alert and the `primarySeconday` with the `primarySecoondary` alert.

```
alertManager.show(dismiss: .custom(title: "AlertKit", message: "AlertKit is awesome", dismissButton: .cancel()))

alertManager.show(dismiss: .success(message: "AlertKit is awesome"))

alertManager.show(dismiss: .error(message: "AlertKit is awesome"))

alertManager.show(dismiss: .warning(message: "AlertKit is awesome"))

alertManager.show(dismiss: .info(message: "AlertKit is awesome"))
```

### 2️⃣ PrimarySecondary Alert

The second type of alert displayes two buttons (instead of one):
- [X] title
- [X] message
- [X] **two** buttons (primary and secondary)

Here are the ways you may call it:

```
alertManager.show(primarySecondary: .custom(title: "AlertKit", message: "AlertKit is awesome", primaryButton: Alert.Button.destructive(Text("OK")), secondaryButton: Alert.Button.cancel()))

alertManager.show(primarySecondary: .success(title: "AlertKit", message: "AlertKit is awesome", primaryButton: Alert.Button.destructive(Text("OK")), secondaryButton: Alert.Button.cancel()))

alertManager.show(primarySecondary: .error(title: "AlertKit", message: "AlertKit is awesome", primaryButton: Alert.Button.destructive(Text("OK")), secondaryButton: Alert.Button.cancel()))

alertManager.show(primarySecondary: .warning(title: "AlertKit", message: "AlertKit is awesome", primaryButton: Alert.Button.destructive(Text("OK")), secondaryButton: Alert.Button.cancel()))

alertManager.show(primarySecondary: .info(title: "AlertKit", message: "AlertKit is awesome", primaryButton: Alert.Button.destructive(Text("OK")), secondaryButton: Alert.Button.cancel()))
```

### ⬆️ Action Sheet

Want **more than two buttons** on the `Alert`? Well, you will have to use an `Action Sheet`:

```
Button("Show Action Sheet") {
    let buttons: [ActionSheet.Button] = [
        .destructive(Text("Do some work"), action: {
            fetchData()
        }),
        .default(Text("Nothing")),
        .cancel()
    ]
    alertManager.showActionSheet(.custom(title: "Action Sheet", message: "What do you want to do next?", buttons: buttons))
}

...

func fetchData {
    ...
}
```

Note that you can use all of the `Alert.Button`s SwiftUI provides. Here I'm using a `destructive` with `action` button and have wrapped the actual work into a seperate `fetchData()` function. Cleaner code 👌

### 🤖 View Model

Speaking of clean code... I highly recommend using a `view model` for your view. Here's mine that is simulating fetching some data by simply letting time pass:

```
//
//  ContentViewModel.swift
//  

import SwiftUI

class ContentViewModel: ObservableObject {
    
    func fetchData(completion: @escaping (Result<Bool, Error>) -> ()) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 4) {
            DispatchQueue.main.async {
//                completion(.success(true))
                completion(.success(false))
//                completion(.failure(NSError(domain: "Could not fetch data", code: 404, userInfo: nil)))
            }
        }
    }
}
```

And in my `ContentView` I'm using it like so:

```
//
//  ContentView.swift
//  

import SwiftUI
import AlertKit

struct ContentView: View {
    
    @StateObject var alertManager = AlertManager()
    @ObservedObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            ...
        }
        .uses(alertManager)
        .onAppear {
            fetchData()
        }
    }
    
    func fetchData() {
        // to see all cases please modify the Result in ContentViewModel
        self.viewModel.fetchData { (result) in
            switch result {
            case .success(let finished):
                if finished {
                    alertManager.show(dismiss: .info(message: "Successfully fetched data", dismissButton: Alert.Button.default(Text("Alright"))))
                } else {
                    alertManager.show(primarySecondary: .error(title: "🤔", message: "Something went wrong", primaryButton: Alert.Button.default(Text("Try again"), action: {
                        fetchData()
                    }), secondaryButton: .cancel()))
                }
            case .failure(let err):
                alertManager.show(dismiss: .error(message: err.localizedDescription))
            }
        }
    }
}
```

## 🪁 Demo project

For a comprehensive Demo project check out: 
<a href="https://github.com/rebeloper/AlertKitDemo">AlertKitDemo</a>

## ✍️ Contact

<a href="https://rebeloper.com/">rebeloper.com</a> / 
<a href="https://www.youtube.com/rebeloper/">YouTube</a> / 
<a href="https://store.rebeloper.com/">Shop</a> / 
<a href="https://rebeloper.com/mentoring">Mentoring</a>

## 📃 License

The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


