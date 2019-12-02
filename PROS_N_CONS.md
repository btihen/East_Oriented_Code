### _Pros & Cons_

**UPSIDES**
- enforces single purpose per class / method, which reduces coupling
- enforces _tell don't ask_ message passing, which reduces unexpected side effects
- easy to use with _injection_ and _behavior decorators_ so relatively easy to extend
- easy to know where a data is mutated, formatted and stored - so generally easy to debug and adapt as changes are needed & if well decoupled using injection, and decorators it is easy to make changes without side-effects or to add new components.

I have found this wonderful when the architecture is basically:

**input -> processing -> output**

Examples:
- CLI scripts
- Background Jobs
- Data conversions outputs

**[Real Use Case](https://github.com/btihen/East_Oriented_Code/blob/master/USE_CASE_NOTES.md)**

**DOWNSIDES**
- well organized and well named files are important - this technique usually leads to MANY small files.
- Rails we can use 'east coding' in isolated parts by returning view objects to the controller using:
    - command objects (runners)
    - input objects
    - view objects (view models)
    - service objects (api interfaces)
    - business objects (rules objects)
    - background jobs
    - DB repository
    - DB query objects
- challenging (even controversial) to use with a "controller" architecture -
    **[Controversial with Controllers (MVC)](https://github.com/btihen/East_Oriented_Code/blob/master/Controversy_with_Controllers.rb)**
