# Primitive Classes

Here are some primitive classes to inherete from, the most important being *ELEMENT*. Create separate files for specific classes, but try to suppress code by inheriting primitive classes. More info:

**ELEMENT**:
Basic class that can have a type, subtype and id, used mostly for drawing.
It also has four extra atributes: invisible, death, exception and handles
 - Use type for generic class type, like "button", "player" or "boss"
 - Use subtype to further classify elements, like "GUI" or "walls".
 - Use id to specify an unique element like "David Robert Jones" or "Excalibur".
 - Invisible is used when drawing the object (if true, the object will not be drawn).
 - Death is used in destroy functions from the *util* module. Use this flag to remove elements from your game.
 - Exception is used when clearing tables (if true, the object will not be removed).
 - Handles is a table containing timer handles the element has. If the object is destroyed, STEAMING will check all running handles and will cancel them from the correspondent timer.
    - Example:
    ```lua
    local boss = BigBoss(x,y)
    boss.handles[MAIN_TIMER] = MAIN_TIMER.after(2, boss.startAnimation)
    ```
 You can use useful methods such as:
 - setId() or setSubTp() to set the correspondent id to this element, and also insert him into auxiliary tables (one for elements with id, another for subtypes) so that the object can be quickly found later.
 - destroy() to cancel any handles this object has (searching through the "handles" table), and then removing the object from DrawTables, Subtype or Id tables.

 **POS**, **CLR**, **DRAWABLE**:
Characteristics one element can have, such as position or color. A drawable has a pos and a clr

**RECT**, **CIRC**, **TRIANGLE**, **IMAGE**:
Simple rectangle circle, triangle and a plain image.


Add/edit more characteristics/shapes/whatever you desire. If in doubt on how to use HUMP classes, check here:
http://hump.readthedocs.io/en/latest/class.html
