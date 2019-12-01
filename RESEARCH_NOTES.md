# Eastward Oriented

### GOAL

*Rules to design good messaging; AKA good OOD* _(as described by Dr. Alan Kay)__

Many people cite this souce as messaging inspiration: _The Meaning of "Object-Oriented Programming"_
http://userpage.fu-berlin.de/~ram/pub/pub_jf47ht81Ht/doc_kay_oop_en

### Summary

- Tell (& trust) -- don't ask!
- Avoid unneeded context

### 4 Rules (Practice)
1) Always return self
2) Objects may only query their own attributes & methods
3) Factories are exempt
4) BreakRules sparingly

### East Oriented (Expected Results)
1) Descrease Coupling
2) Increases Code Clarity
3) Increases Code Coheason 
4) Increases Code Flexibility
5) Increases Scope Enforcement / Data Security

### Definitions

Presentation on Messaging with code samples using East Orientation (& Injection)
- **Eastward** is sending a message
- **Westward** is recieving a message
- **Injection** avoid hardcoding Classes send in necessary objects as a collaborating varaible


## Sample Code - TOC

*Jim Gay's** sample address code reminded me of when Eastward really helped me 
(moving data between servers with many format and transport needs and based on many different triggers)

- **00_jim_gay_refactor_process.md** - listing of Jim's refactoring steps to go from East-West to East Oriented Code
- **01_east_west_address.rb** is east-west, very simple and clear -- great when flexibility isn't needed
- **02_east_address.rb** is east only and uses an additional template class, but much more flexible
- **03_east_injection_address.rb** - demostrates how with east and injection very flexible apps can be build
- **04_east_west_chain_tale.rb** - Sandi Metzt code from "Nothing is Something"
- **05_east_chain_tale.rb** - Converted Chain Tale code to east code 
- **06_east_injection_chain_tale.rb** - added Sandi's role injection (like in the talk) with the east code.
- **07_east_command_module.rb** - code from Jim Gay on East Orientation with Delegation and wrapping non-east code
- **08_east_injection_alarm.rb** - playing with Avdi Grimm's take on messaging and dynamic injection


## Practical USE CASES?

- Backtround Jobs
- complex CLI scripts
- Data conversions outputs

#### Context when I found VERY HELPFUL

Data transfer between many services.
Differing Changes needed different triggers (applied, application fee paid, application received & completed, accepted by school, acceptance confirmed, tution paid, health records submitted, travel plans submitted, visa approved, ...)
Differing Services need different dqta formats (CSV, PNG, EXCEL, API (json & objects))
Differing Services had differnt data transport needs (FTP, SCP, API, ect)

#### Data Sources
- HR Server (master data source for employees)
- Admission Server (master data source for students and parents) - API
- Phone assignment server (master data source for all school phones - employees and students)
- photographer (student photos)

#### Data Consumers
- Parental Payments Services Management
- LDAP Server (master authenication & authorization)
- Google Services (email, google docs, etc)
- Canton VD Immegration Applications
- Academic Management Server (classes, grades, attendance)
- Travel & Dormitory Absence Tracking (and fire lists)
- Health Records Tracking
- Parent Portal
- Cell Phone 
- Student / Staff ID Formatter & Printer
- Restricted WEB Portal (Rails)
  - for access to student photos
  - start of year Dormitory assigments 
    (allows dorm staff to coordinate with admissions - dorm staff don't have access to the admissions server)
  - start of year Grade / Course assignments 
    (allows academic planners to coordinate with admissions on new students interests and abilities before creating academic schedules)



## Resources 

**James Ladd** - started Eastward Oriented (original blog is gone)
- new post: "Why we fail at OO": http://jamesladdcode.com/?p=12

**Jim Gay** EASTWARD APPLIED to RUBY: (RubyConf 2014) Eastward Ho!
- Talk: https://www.youtube.com/watch?v=kXcrClJcfm8
- Blog: https://www.saturnflyer.com/blog/enforcing-encapsulation-with-east-oriented-code
  - https://www.saturnflyer.com/blog/the-4-rules-of-east-oriented-code-rule-1
  - https://www.saturnflyer.com/blog/the-4-rules-of-east-oriented-code-rule-2
  - https://www.saturnflyer.com/blog/the-4-rules-of-east-oriented-code-rule-3
  - https://www.saturnflyer.com/blog/the-4-rules-of-east-oriented-code-rule-4

**Sandi Metz** has a nice talk on roles & injection: 'Nothing is Something'
- talk: https://www.youtube.com/watch?v=OMPfEXIlTVE
- blog: https://www.sandimetz.com/blog/2014/9/9/shape-at-the-bottom-of-all-things


# Eastward/Decoupled WebApp?

Lots of efforts
- **Roda** - https://roda.jeremyevans.net/
- **Hanami** - https://hanamirb.org/
- **Sinatra** - http://sinatrarb.com/
- **Trailblazers** - http://trailblazer.to/

## Decoupled (Hexagonal) Rails

**Jim Wienrich** - _Decoupling from Rails_, (CincyRb, Oct 15, 2013)
- VIDEO: https://www.youtube.com/watch?v=tg5RFeSfBM4
- CODE: https://github.com/jimweirich/wyriki
Experimental Rails application to explore decoupling app logic from Rails.

**Robert Martin** - _Architecture the Lost Years_, (Keynote at Ruby Midwest 2011)
inspired _Decoupling from Rails_ 
- https://www.youtube.com/watch?v=hALFGQNeEnU
- https://www.youtube.com/watch?v=HhNIttd87xs

#### SUPPORT for "Decoupled Rails" - by Robert C. Martin (Uncle Bob)
Test Induced Design Damage?
https://blog.cleancoder.com/uncle-bob/2014/05/01/Design-Damage.html


#### CRITISM against "Decoupled Rails" - by DHH
Blog: There may well be proper uses for it outside the domain of web apps.
https://dhh.dk/2014/test-induced-design-damage.html

DHH Sample Code (from Decoupling from Rails talk) - test_induced_design_damage.rb
code & discussion
https://gist.github.com/dhh/4849a20d2ba89b34b201




# Further Info

**James Ladd**
- new post: "Why we fail at OO": http://jamesladdcode.com/?p=12
- original post "A Design Compass: East Oriented": http://jamesladdcode.com/2007/02/14/east-a-technique/

In addition to East Oriented Design I also promote following the Object Calisthenics approach (http://jamesladdcode.com/2017/02/03/object-calisthenics/)
- Object Calisthenics are programming exercises, formalized as a set of 9 rules invented by Jeff Bay in the book: 
  - _The ThoughtWorks Anthology (out of Print),_ by Jeff Bay
  - Jeff Bay also wrote this article (still available): https://www.cs.helsinki.fi/u/luontola/tdd-2009/ext/ObjectCalisthenics.pdf


**Pete DiSalvo**
- Suggested sample code (chess game & discussion) 
https://github.com/TheSecretSquad/chess
- Suggested Blog (suumary):
https://thesecretsquad.wordpress.com/2014/10/25/dazed-and-confuzzled/

**Pete's Summary**
The receiving objects respond to messages by changing their state or sending other messages, which their collaborators receive, and so on. Objects don’t know who is responding to the message, and in many cases they don’t know what will happen in response. They 

just know to send the message and trust the object hooked up to it at run time responds with the correct behavior.
The thing about messaging is data becomes irrelevant. Data is hidden within objects, and used to store the state of objects. Objects use this state to decide which messages they should send. Objects can’t ask collaborators for their state or data and operate on it. The only way objects release state is by sending a message signaling a significant event. Other objects can register to receive the message and respond to it. This type of design naturally leads to East Oriented code because you’re not returning data (west).

We are attempting to avoid unneeded context
- East send message to immediate neighbor only
- Trust the receiving object to respond correctly 
- The messages should focus on what not how (method names need to focus on a delegated activity)


**Sandi Metz** (https://www.sandimetz.com/)

_Practical Object-Oriented Design in Ruby_ (https://www.poodr.com/)
The public interface to an object is not “what the object does”. The public interface to an object consists of the messages it responds to; “what an object does” consists of the messages it sends.

**Method Naming** for good messaging:

_avoid_
- dog.express_happiness if ball_thrown

_use_
- dog.ball_thrown


**Kent Beck** and **Ward Cunningham** say in (http://c2.com/doc/oopsla89/paper.html), “The most difficult problem in teaching object-oriented programming is getting the learner to give up the global knowledge of control that is possible with procedural programs, and rely on the local knowledge of objects to accomplish their tasks.”[3]
