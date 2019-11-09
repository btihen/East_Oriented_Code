# Eastward Oriented

### GOAL:

*Rules to design good messaging; AKA good OOD* _(as described by Dr. Alan Kay)__

Many people cite this souce as messaging inspiration: _The Meaning of "Object-Oriented Programming"_
http://userpage.fu-berlin.de/~ram/pub/pub_jf47ht81Ht/doc_kay_oop_en

### Definitions

Presentation on Messaging with code samples using East Orientation (& Injection)
- *Eastward* is sending a message
- *Westward* is recieving a message
- *Injection* avoid hardcoding Classes send in necessary objects as a collaborating varaible

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


# Eastward Rails?

*Jim Wienrich*
- _Decoupling from Rails_ - EastCode/HexCode with a web app
  - https://www.youtube.com/watch?v=tg5RFeSfBM4
  - SAMPLE CODE: https://github.com/jimweirich/wyriki
Experimental Rails application to explore decoupling app logic from Rails.

*Robert Martin* - inspired _Decoupling from Rails_ with his Keynote at Ruby Midwest 2011
- _Architecture the Lost Years_
  - https://www.youtube.com/watch?v=hALFGQNeEnU
  - https://www.youtube.com/watch?v=HhNIttd87xs

### SUPPORT for Decoupled Rails - by Robert C. Martin (Uncle Bob)
Test Induced Design Damage?
https://blog.cleancoder.com/uncle-bob/2014/05/01/Design-Damage.html


### CRITISM against Decoupled Rails - by DHH
Blog: There may well be proper uses for it outside the domain of web apps.
https://dhh.dk/2014/test-induced-design-damage.html

DHH Sample Code (from Decoupling from Rails talk) - test_induced_design_damage.rb
code & discussion
https://gist.github.com/dhh/4849a20d2ba89b34b201


# Valid USE CASES

- Backtround Jobs
- complex CLI scripts
- Data conversions outputs

### Context when I used

Data transfer between many services.
Differing Changes needed different triggers (applied, application fee paid, application received & completed, accepted by school, acceptance confirmed, tution paid, health records submitted, travel plans submitted, visa approved, ...)
Differing Services need different dqta formats (CSV, PNG, EXCEL, API (json & objects))
Differing Services had differnt data transport needs (FTP, SCP, API, ect)

### Services Summary 

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

### Sample Code

*Address Code* has many analogies (and much smaller domain to code)


# Further Info

### James Ladd: 
- new post: "Why we fail at OO": http://jamesladdcode.com/?p=12
- original post "A Design Compass: East Oriented": http://jamesladdcode.com/2007/02/14/east-a-technique/

In addition to East Oriented Design I also promote following the Object Calisthenics approach (http://jamesladdcode.com/2017/02/03/object-calisthenics/)
- Object Calisthenics are programming exercises, formalized as a set of 9 rules invented by Jeff Bay in the book: 
  - _The ThoughtWorks Anthology (out of Print),_ by Jeff Bay
  - Jeff Bay also wrote this article (still available): https://www.cs.helsinki.fi/u/luontola/tdd-2009/ext/ObjectCalisthenics.pdf

- Suggested sample code (chess game & discussion) 
https://github.com/TheSecretSquad/chess
- Suggested Blog (suumary):
https://thesecretsquad.wordpress.com/2014/10/25/dazed-and-confuzzled/
The receiving objects respond to messages by changing their state or sending other messages, which their collaborators receive, and so on. Objects don’t know who is responding to the message, and in many cases they don’t know what will happen in response. They just know to send the message and trust the object hooked up to it at run time responds with the correct behavior.
The thing about messaging is data becomes irrelevant. Data is hidden within objects, and used to store the state of objects. Objects use this state to decide which messages they should send. Objects can’t ask collaborators for their state or data and operate on it. The only way objects release state is by sending a message signaling a significant event. Other objects can register to receive the message and respond to it. This type of design naturally leads to East Oriented code because you’re not returning data (west).

We are attempting to avoid unneeded context
- East send message to immediate neighbor only
- Trust the receiving object to respond correctly 
- The messages should focus on what not how (method names need to focus on a delegated activity)
# very flexible if action is injected (like a template): printAddress(format: HtmlFormat)
# Sandi Metz has a nice talk on this: 'Nothing is Something': 
# talk: https://www.youtube.com/watch?v=OMPfEXIlTVE
# blog: https://www.sandimetz.com/blog/2014/9/9/shape-at-the-bottom-of-all-things

Sandi Metz - Practical Object-Oriented Design in Ruby
The public interface to an object is not “what the object does”. The public interface to an object consists of the messages it responds to; “what an object does” consists of the messages it sends.
avoid:
dog.express_happiness if ball_thrown
use:
dog.ball_thrown


http://c2.com/doc/oopsla89/paper.html
Kent Beck and Ward Cunningham said, “The most difficult problem in teaching object-oriented programming is getting the learner to give up the global knowledge of control that is possible with procedural programs, and rely on the local knowledge of objects to accomplish their tasks.”[3]


EastOriented - tell-dont-ask
MESSAGING RULES - avoid unneeded context


### RUBY Focus

Jim Gay (RubyConf 2014)

Talk: Eastward Ho! A Clear Path Through Ruby With OO
-----
https://www.youtube.com/watch?v=kXcrClJcfm8

Blog:
---- 
https://www.saturnflyer.com/blog/enforcing-encapsulation-with-east-oriented-code
https://www.saturnflyer.com/blog/the-4-rules-of-east-oriented-code-rule-1
https://www.saturnflyer.com/blog/the-4-rules-of-east-oriented-code-rule-2
https://www.saturnflyer.com/blog/the-4-rules-of-east-oriented-code-rule-3
https://www.saturnflyer.com/blog/the-4-rules-of-east-oriented-code-rule-4

4 Rules (summary)
-----------------
1) Always return self 
2) Objects may only query themselves (their own attributes & methods)
3) Factories are exempt
4) BreakRules sparingly (at some point code must return a value to the user / hard-drive, etc)

East Oriented (GOALS)
---------------------
1) Descrease Coupling
2) Increases Code Clarity
3) Increases Code Coheason 
4) Increases Code Flexibility
2) Increases Scope Enforcement / Data Security


