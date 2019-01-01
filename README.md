# Cross Check Spec Harness

## Setup

First, make sure that you have a directory called `cross_check` that contains all the code for you project. For example, inside the `cross_check` directory should be `lib`, `test`, and `data` directories. The spelling must be exactly `cross_check`.

Navigate to the directory where `cross_check` is located and clone this repository. Make sure you not *inside* the `cross_check` directory, but rather adjacent to it, i.e. if you enter `ls` you should see `cross_check` listed.

After you clone, the directory structure should look like this:

  ```
    <some_directory>
    |
    |\
    | \<cross_check>
    |
    |\
    | \<cross_check_spec_harness>
  ```

Change into the `cross_check_spec_harness` directory and run `bundle` from the command line. If you get an error that says the bundle command cannot be found, run `gem install bundle` from the command line and try again.

## Usage

From the `cross_check_spec_harness` directory, in the command line run `bundle exec rspec`. This will run a test suite for the `StatTracker` class as described in the project page.

In order for the test suite to run, all requirement statements inside your project's `lib` directory need to be `require_relative` rather than `require`. For example, if in your `stat_tracker.rb` file you have a line:

```ruby
require './lib/helper_class'
```

You should change it to use a `require_relative`:

```ruby
require_relative './helper_class'
```

You do not need to change any of the require statements inside your `test` directory.
