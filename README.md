# East Oriented Code

**Better Message Passing -> Better Object Code**

### Definition

Presentation on Messaging with code samples using East Orientation (& Injection)
- **Eastward** is sending a message (telling)
- **Westward** is receiving a message (usually after asking)

### People / History

**Dr. Alan Kay** - Rules to design good messaging; AKA good OOD
Many people cite this source as messaging inspiration: _The Meaning of "Object-Oriented Programming"_ http://userpage.fu-berlin.de/~ram/pub/pub_jf47ht81Ht/doc_kay_oop_en

**James Ladd** - Created Eastward Oriented Rules (original blog is gone)
- new post: "Why we fail at OO": http://jamesladdcode.com/?p=12

**Jim Gay** EASTWARD APPLIED to RUBY: (RubyConf 2014) Eastward Ho!
- Talk: https://www.youtube.com/watch?v=kXcrClJcfm8
- Blog: https://www.saturnflyer.com/blog/enforcing-encapsulation-with-east-oriented-code

### East Code Practices

1. **Methods Always return 'self'** - TELL DON'T ASK (factories/initializers are exempt)
  - **Objects ONLY CHANGE own attributes** (avoid public attribute assignments)!!
  - **Objects ONLY QUERY own methods** (avoid publicly visible attributes)
2. **Break the Rules sparingly** - (pass only immutable value or view objects)

**Upside**
- enforces single purpose per class / method, which reduces coupling
- enforces _tell don't ask_ message passing, which reduces unexpected side effects
- easy to use with _injection_ and _behavior decorators_ so relatively easy to extend
- easy to know where a data is mutated, formatted and stored - so generally easy to debug and adapt as changes are needed & if well decoupled using injection, and decorators it is easy to make changes without side-effects or to add new components.

**Downside** - well organized and well named files are important - this technique usually leads to MANY small files.

### Informal Usage

- **Tell, don't ask** - be private (single responsibility)
- **Exception** - pass a data/value object for output or worse case a hash

## Sample Code

*Jim Gay's** sample address code reminded me of when Eastward really helped me
(moving data between servers with many format and transport needs and based on many different triggers)

- **[01_east_west_address.rb](https://github.com/btihen/East_Oriented_Code/blob/master/01_east_west_address.rb)** is east-west, very simple and clear -- great when very simple and flexibility isn't needed
- **[02_east_address.rb](https://github.com/btihen/East_Oriented_Code/blob/master/02_east_address.rb)** is east only is great when additional for flexible outputs and keeping processing clear (only objects can change and query themselves)

**Time Permitting**
- **[00_jim_gay_refactor_process.md](https://github.com/btihen/East_Oriented_Code/blob/master/00_jim_gay_refactor_process.md)** - Jim Gay's refactoring process from East/West to West
- **[03_east_injection_address.rb](https://github.com/btihen/East_Oriented_Code/blob/master/03_east_injection_address.rb)** - injection and decorators allow lots of flexibility and complexity while preserving the benefits of East Orientated Message passing with one place data is mutated and single purpose for each class.


## Controversy using with Controllers (MVC)

**Robert Martin** - _Architecture the Lost Years_, (Keynote at Ruby Midwest 2011)
inspired _Decoupling from Rails_
- https://www.youtube.com/watch?v=hALFGQNeEnU
- https://www.youtube.com/watch?v=HhNIttd87xs

**Jim Wienrich** - _Decoupling from Rails_, (CincyRb, Oct 15, 2013)
- VIDEO: https://www.youtube.com/watch?v=tg5RFeSfBM4
- CODE: https://github.com/jimweirich/wyriki
Experimental Rails application to explore decoupling app logic from Rails.

#### SUPPORT for "Decoupled Rails" - by Robert C. Martin (Uncle Bob)
Test Induced Design Damage?
https://blog.cleancoder.com/uncle-bob/2014/05/01/Design-Damage.html

#### CRITICISM against "Decoupled Rails" - by DHH
Blog: There may well be proper uses for it outside the domain of web apps.
https://dhh.dk/2014/test-induced-design-damage.html

DHH sample code / discussion called 'test induced design damage'
https://gist.github.com/dhh/4849a20d2ba89b34b201


## GOOD USE CASES

I have found this wonderful when the architecture is basically:
**input -> processing -> output**
and _very challenging (even controversial) to use with a "controller" architecture._

- CLI scripts
- Background Jobs
- Data conversions outputs

[My Sample Use Case]()
