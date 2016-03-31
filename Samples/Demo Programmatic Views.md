# Demo: Programmatic Views

## Goal

The goal of this short demo is to quickly demonstrate some of the programmatic view concepts we are about to review during the slides and get the student in the right mind set about doing all this stuff in code.

## Preparation

No preparation needed. You'll be making a new projected.

### Create a New Project

* Create a new iOS project in Xcode using the Single View Application template.
* Name the project `ViewDemo`.
* Make sure it's using Swift and targeted at iPhone devices.
* Feel free to uncheck core data, unit tests, and ui tests options

### Force the ViewController class to be programmatic

* Open the `Main.storyboard` 
* Highlight `ViewController`
* Select the view and hit delete
* Explain that we'll be building the view in code and this is a great example of how it need not be storyboards or code, you can mix and match. (eg: we might keep this and build segues in the storyboard)
	- 
### Edit `ViewController.swift` and add `loadView`

* Update the `ViewController.swift` file to be just the class declaration

````swift
import UIKit
class ViewController: UIViewController {

}
````

* Add a loadView implementation that setups a plain orange view
* Explain why we don't call super 

````swift
override func loadView() {
    view = UIView()
    view.backgroundColor = UIColor.orangeColor()
}
````

### Create a label and add it

* Create a simple label called `greeting`
* Assign it some text and give it a background color for easier debugging
* Add it to the view

````swift
let greeting = UILabel()
greeting.text = "Hello World"
greeting.backgroundColor = UIColor.blueColor()
view.addSubview(greeting)
````

### Test the app, notice bugs

* Run the app
* Notice we don't see the greeting
* Use the view debugger to look for it in 3D space
* Use the jump bar to see that the view is there
* Jump back to the code and add some caveman debugging
* Add `print(greeting.frame)`
* Notice Output: `(0.0, 0.0, 0.0, 0.0)`

### Fix bugs by adding a frame


* Add `let greeting = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))`
* Demo the solution
* Explain that this solution is not a valid one, need Auto Layout

### Fix bugs by adding constraints

* Explain our goal is to get the greeting aligned at the top and centered. 
* Add: `greeting.translatesAutoresizingMaskIntoConstraints = false`
* Explain this turns off old layout system, acknowledges we we manage all constraints.
* Add the following:

````swift
let c1 = greeting.topAnchor.constraintEqualToAnchor(view.topAnchor)
let c2 = greeting.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
c1.active = true
c2.active = true
````

### Demo first pass at constraint solution 

* Explain how we are building constraints and then installing/activating them using these convenance APIs.
* Test the app, notice it mostly works but interferes with the clock
* Explain we can setup constrains to view, margins and guides.
	 - 
### Let's use a layout guide to avoid the status bar

* Update the first constraint to be:

````swift
let c1 = greeting.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor)
````

### Demo change, now below the status bar
		
* Demo working view

### Extra Credit, When does layout happen?

* If you still have the caveman debugging `print(greeting.frame)` at the tail of the loadView method you'll notice it's still all zeros, why?
* Layout doesn't happen until later. If you want to see the final frame you can edit the code to hold on to the `greeting` label and then implement `viewDidLayoutSubviews`

````swift
override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    print(greeting.frame)
}
````

### END
