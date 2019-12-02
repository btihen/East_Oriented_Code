# **East Oriented Code**

#### Better Message Passing == Better Code

## __BACKGROUND__

### _Definition_

Presentation on Messaging with code samples using East Orientation (& Injection)
- **Eastward** is sending a message (telling)
- **Westward** is receiving a message (usually after asking)

### _CREDIT_

- **Dr. Alan Kay** - Rules to design good messaging; AKA good OOD.  Many people cite this source as messaging inspiration:
    - _The Meaning of "Object-Oriented Programming"_ http://userpage.fu-berlin.de/~ram/pub/pub_jf47ht81Ht/doc_kay_oop_en

- **James Ladd** - Created Eastward Oriented Rules _(original blog is unavailable)_
    - **Blog:** "Why we fail at OO": http://jamesladdcode.com/?p=12

- **Jim Gay** EASTWARD APPLIED to RUBY: (RubyConf 2014) Eastward Ho!
    - **Talk:** https://www.youtube.com/watch?v=kXcrClJcfm8
    - **Blog:** https://www.saturnflyer.com/blog/enforcing-encapsulation-with-east-oriented-code & https://www.saturnflyer.com/blog/the-4-rules-of-east-oriented-code-rule-1

### _Practices_

Enforced **Tell - Don't Ask**

1. **Always Return 'self'** - especially public methods - (factories & initializers exempt)
2. **Objects MAY ONLY QUERY itself** - avoid public getters!
3. **Objects MAY ONLY CHANGE their own state** - avoid public setters!
4. **Break the Rules sparingly** - mostly for output -- then pass a simple object (ideally immutable) - _think Structs & View-Models_

Rules 2 & 3 are basically unnecessary if rule 1 is followed closely!

### _HELPFUL & CONTROVERSIAL_

**EASY & HELPFUL:** with a pipeline architecture:

**input -> processing -> output**

Examples:
- CLI scripts
- Background Jobs
- Data conversions outputs

*[Use Case - A Data Exchange](https://github.com/btihen/East_Oriented_Code/blob/master/USE_CASE_NOTES.md)*

**CONTROVERSIAL** to use with a "controller" architecture - that expects to "control" - the opposite of East Oriented code.

* **Jim Weirich** - [Decoupling from Rails](https://www.youtube.com/watch?v=tg5RFeSfBM4) & his [sample code (summarized by DHH)](https://gist.github.com/dhh/4849a20d2ba89b34b201)
* **DHH** - [Calls this Test Driven Damage](https://dhh.dk/2014/test-induced-design-damage.html)
* **Uncle Bob** [Support for Decoupling](https://blog.cleancoder.com/uncle-bob/2014/05/01/Design-Damage.html) & [Architecture the Lost Years](https://www.youtube.com/watch?v=hALFGQNeEnU)


### _Informal Practice_

When Strict East isn't practical

Helpful for daily coding - when East Oriented not practical
- **Tell, don't ask** - Could I return self?, What else canI make private?
- **Exceptions common** - pass a data for output & formatting - using view-models, value-objects, struct or minimally a hash

I like to explore the practice of getting as close as possible to East Oriented (along with Sandi Metz's Code Complexity Rules & Behavior Injection)

## __CODE__

I don't have access to the _Data Exchange_ I wrote for my previous employer - but **Jim Gay's** address code can use a similar pipeline flow

- **[01_east_west_address.rb](https://github.com/btihen/East_Oriented_Code/blob/master/01_east_west_address.rb)** - is east-west, very simple and clear -- great when very simple and flexibility isn't needed
- **[02_east_address.rb](https://github.com/btihen/East_Oriented_Code/blob/master/02_east_address.rb)** - is east only is great when additional for flexible outputs and keeping processing clear (only objects can change and query themselves)

_Given Time and Interest_

- **[03_east_injection_address.rb](https://github.com/btihen/East_Oriented_Code/blob/master/03_east_injection_address.rb)** - injection and decorators allow lots of flexibility and complexity while preserving the benefits of East Orientated Message passing with one place data is mutated and single purpose for each class.
- **[00_jim_gay_refactor_process.md](https://github.com/btihen/East_Oriented_Code/blob/master/00_jim_gay_refactor_process.md)** - Jim Gay's refactoring process from East/West to West
