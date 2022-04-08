# Class Def

A ruby script that can convert a JSON object into a Swift struct defintion.

The script can be invoked inline:

`ruby ClassDef.rb -i {\"some\":\"data\"}`

or it can read from a json file you have saved:

`ruby ClassDef.rb -d "somedata.json"`

# To-Do

- Add support for nullable properties
- Decouple Swift language features from `Property.rb`
- Add support for default values
- Add to Homebrew
- Add option to generate .swift files directly
- Support other statically typed languages?

This app has dreams of being a command line tool for converting JSON into class definitions in multiple statically typed languages. It will probably never get there, but we should never abandon our dreams. (✿◠‿◠)
