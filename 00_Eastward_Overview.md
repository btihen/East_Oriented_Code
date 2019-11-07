# East_Oriented

EastOriented - MESSAGING RULES
- tell dont ask!
- avoid unneeded context

4 Rules (summary)
=================
1) Always return self 
2) Objects may only query themselves (their own attributes & methods)
3) Factories are exempt
4) BreakRules sparingly (at some point code must return a value to the user / hard-drive, etc)


Dr. Alan Kay 
Meaning of “Object-Oriented Programming”
http://userpage.fu-berlin.de/~ram/pub/pub_jf47ht81Ht/doc_kay_oop_en

Alan Kay Summary 
http://mythz.servicestack.net/blog/2013/02/27/the-deep-insights-of-alan-kay/

James Ladd (Java): 
- new post: "Why we fail at OO": http://jamesladdcode.com/?p=12
- original post "A Design Compass: East Oriented": http://jamesladdcode.com/2007/02/14/east-a-technique/

GOAL:
-----
Rules to easily design good messaging aka good OOD (as described by Dr. Alan Kay)

# sample code: chess game & discussion (Java): 
# https://github.com/TheSecretSquad/chess
# James Ladd - Suggested Blog: https://thesecretsquad.wordpress.com/2014/10/25/dazed-and-confuzzled/
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

# http://c2.com/doc/oopsla89/paper.html
Kent Beck and Ward Cunningham said, “The most difficult problem in teaching object-oriented programming is getting the learner to give up the global knowledge of control that is possible with procedural programs, and rely on the local knowledge of objects to accomplish their tasks.”[3]


EastOriented - tell-dont-ask
MESSAGING RULES - avoid unneeded context


RUBY - Jim Gay (RubyConf 2014)
----
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


Jim Weirich - "Decoupling from Rails" 
(EastCode/HexCode with a web app - allowing a large web app to grow)
https://www.youtube.com/watch?v=tg5RFeSfBM4
SAMPLE CODE:
https://github.com/jimweirich/wyriki
Experimental Rails application to explore decoupling app logic from Rails.
# inspired by Robert Martin - Ruby Midwest 2011 - Keynote: Architecture the Lost Years
# https://www.youtube.com/watch?v=hALFGQNeEnU
# Robert "Uncle Bob" Martin - Architecture: The Lost Years
# https://www.youtube.com/watch?v=HhNIttd87xs

SUPPORT:
by Robert C. Martin (Uncle Bob)
Test Induced Design Damage?
https://blog.cleancoder.com/uncle-bob/2014/05/01/Design-Damage.html


CRITISM:
by DHH
https://dhh.dk/2014/test-induced-design-damage.html
There may well be proper uses for it outside the domain of web apps.

DHH Sample Code (from Decoupling from Rails talk) - test_induced_design_damage.rb
code & discussion
https://gist.github.com/dhh/4849a20d2ba89b34b201


Object Calisthenics
===================
Maybe a better fit for Rails
----------------------------
ThoughtWorks Anthology (out of Print)
by ThoughtWorks (Jeff Bay)
https://pragprog.com/titles/twa/thoughtworks-anthology

Web Version (PDF)
9 steps to better software design today, by Jeff Bay
https://www.cs.helsinki.fi/u/luontola/tdd-2009/ext/ObjectCalisthenics.pdf
This is a hard exercise, especially because many of these rules are not universally applicable.
The Rules
---------
1. One level of indentation per method
2. Don’t use the ELSE keyword 
3. Wrap all primitives and Strings
4. First class collections
5. One dot per line
6. Don’t abbreviate
7. Keep all entities small
8. No classes with more than two instance variables
9. No getters/setters/properties

# another take
https://williamdurand.fr/2013/06/03/object-calisthenics/
These rules focus on maintainability, readability, testability, and comprehensibility of your code.


# My actual use case





