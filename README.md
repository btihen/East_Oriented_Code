# **East Oriented Code**

_Better Message Passing -> Better Object Code_

## __BACKGROUND__

### _Definition_

Presentation on Messaging with code samples using East Orientation (& Injection)
- **Eastward** is sending a message (telling)
- **Westward** is receiving a message (usually after asking)

### _People & History_

- **Dr. Alan Kay** - Rules to design good messaging; AKA good OOD.  Many people cite this source as messaging inspiration:
    - _The Meaning of "Object-Oriented Programming"_ http://userpage.fu-berlin.de/~ram/pub/pub_jf47ht81Ht/doc_kay_oop_en

- **James Ladd** - Created Eastward Oriented Rules _(original blog is unavailable)_
    - **Blog:** "Why we fail at OO": http://jamesladdcode.com/?p=12

- **Jim Gay** EASTWARD APPLIED to RUBY: (RubyConf 2014) Eastward Ho!
    - **Talk:** https://www.youtube.com/watch?v=kXcrClJcfm8
    - **Blog:** https://www.saturnflyer.com/blog/enforcing-encapsulation-with-east-oriented-code

### _Practices_

1. **Methods return 'self'** - TELL DON'T ASK - factories & initializers exempt
    - **Objects ONLY CHANGE own attributes** - avoid public attribute assignments!
    - **Objects ONLY QUERY (ask) own methods/attributes** - avoid publicly visible attributes and info-return methods
2. **Break the Rules sparingly** - pass view objects (ideally immutable), worst case a hash (or named tuple)


### _My Informal Practices_

Helpful for daily coding - when East Oriented not practical
- **Tell, don't ask** - be private (single responsibility)
- **Exceptions common** - pass a data for output & formatting - using view-models, value-objects, struct or minimally a hash


### _HELPFUL & CONTROVERSIAL_

**VERY HELPFUL:** with a pipeline architecture:

**input -> processing -> output**

Examples:
- CLI scripts
- Background Jobs
- Data conversions outputs

*[Use Case - A Data Hub](https://github.com/btihen/East_Oriented_Code/blob/master/USE_CASE_NOTES.md)*

**CONTROVERSIAL** to use with a "controller" architecture - that expects to "control" - the opposite of East Oriented code.

* **Jim Weirich** - [Decoupling from Rails](https://www.youtube.com/watch?v=tg5RFeSfBM4) & his [sample code (summarized by DHH)](https://gist.github.com/dhh/4849a20d2ba89b34b201)
* **DHH** - [Calls this Test Driven Damage](https://dhh.dk/2014/test-induced-design-damage.html)
* **Uncle Bob** [Support for Decoupling](https://blog.cleancoder.com/uncle-bob/2014/05/01/Design-Damage.html) & [Architecture the Lost Years](https://www.youtube.com/watch?v=hALFGQNeEnU)


## __CODE__

### _Sample Code_

**Jim Gay's** sample address code reminded me of a simple data flow (between servers)

- **[01_east_west_address.rb](https://github.com/btihen/East_Oriented_Code/blob/master/01_east_west_address.rb)** - is east-west, very simple and clear -- great when very simple and flexibility isn't needed
- **[02_east_address.rb](https://github.com/btihen/East_Oriented_Code/blob/master/02_east_address.rb)** - is east only is great when additional for flexible outputs and keeping processing clear (only objects can change and query themselves)

### _With Time and Interest_

- **[00_jim_gay_refactor_process.md](https://github.com/btihen/East_Oriented_Code/blob/master/00_jim_gay_refactor_process.md)** - Jim Gay's refactoring process from East/West to West
- **[03_east_injection_address.rb](https://github.com/btihen/East_Oriented_Code/blob/master/03_east_injection_address.rb)** - injection and decorators allow lots of flexibility and complexity while preserving the benefits of East Orientated Message passing with one place data is mutated and single purpose for each class.
