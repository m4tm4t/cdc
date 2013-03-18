Why ?
-----
Devise is cool, but not when you have to override all controllers (for breadcrumbs by example).
This script do the job for you

Usage
-----
Run this script on the ROOT of your Rails app.
You will be prompted for modules you want and the scope

    $ bash <(curl -s https://raw.github.com/foohey/cdc/master/cdc.sh)

Output

    Specify devise scope ('users' by default) : 
    Devise modules: sessions registrations passwords unlocks confirmations
    Specify devise module(s) you want to override, separated by a space. (all by default) : 
    Generating controller for sessions ...
    Generating controller for registrations ...
    Generating controller for passwords ...
    Generating controller for unlocks ...
    Generating controller for confirmations ...
    
Now you have empty controllers to start override Devise, yeah !

```ruby
class Users::SessionsController < Devise::SessionsController
  # def new
  #   super
  # end

  # def create
  #   super
  # end
end
```

Customizing the controller template is easy. Just download and edit the script at:
```bash
function controller_template {
cat <<RubyCode
class ${1}::${2}Controller < Devise::${2}Controller
  # def new
  #   super
  # end

  # def create
  #   super
  # end
end
RubyCode
}
```
