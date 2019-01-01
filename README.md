# Cross Check Spec Harness

## Setup

Clone this repository into the same directory as your `Cross Check` project (not inside your `Cross Check` project directory). The directory structure should look like this:

  ```
    <some_directory>
    |
    |\
    | \<your cross check project>
    |
    |\
    | \<cross_check_spec_harness>
  ```

Change into the `cross_check_spec_harness` directory and run `bundle` from the command line. If you get an error that says the bundle command cannot be found, run `gem install bundle` from the command line and try again.

## Usage

From the `cross_check_spec_harness` directory, in the command line run `bundle exec rspec`. This will run a test suite for the `StatTracker` class as described in the project page.

In order for this to work, all requirement statements inside your project's `lib` directory need to be `require_relative` rather than `require`. For example, if in your `stat_tracker.rb` file you have a line:

```ruby
require './lib/helper_class'
```

You should change it to use a `require_relative`:

```ruby
require_relative './helper_class'
```

You do not need to change any of the require statements inside your `test` directory.
