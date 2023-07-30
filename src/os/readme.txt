# CAOSLang
## Declaration
### Values
There are 3 value types: Number (N), Address (A), Enviorment (E) and String (S)

To store a value run $STORE ?(POOL):A ?(VALUE:TYPE)

There are two pools, Live (L) Alpha (A)

Live - opperative location
### Launchpads
Launchpads are locations for execution

To make a launchpad run $PAD ?(VALUE:TYPE)

When running the code runs from launchpad 0

#### Jumping to launchpads
To jump to a launchpad run $JUMP ?(VALUE:TYPE) ?(VALUE:TYPE)

Note: the first value after the @ must be more then one and the second is the target
## Counting
For addition run $ADD ?(VALUE:TYPE)

it adds the value to the live container

For subtraction run $SUB ?(VALUE:TYPE)

it removes the value from the live container

To fetch a value to and from the live container use the > or < opperator

Write by running: <

Fetch by running: >
## IO
Execute a command with $EXEC ?(COMMAND):S

Take a input with $IN ?(STRING):S

Print a value with $OUT ?(VALUE:TYPE)

Convert a number to string with $CON ?(VALUE):N

To append a value to a file run $APPEND ?(PATH):S ?(VALUE:TYPE)

To read a file run $READ ?(PATH):S
## Other features
to make a enviorment value run $STORE ?(ID):E

then to set the enviorment value run # ?(ID):N ?(VALUE:TYPE)

to clear the value simply run $DROP ?(ID):N

to halt execution run !
## Examples
#### Dubbler
$PAD ?0:N

$ADD ?2:N

$PAD ?MAIN_LOOP:S

$ADD ?L:A

$OUT ?L:A

$JUMP ?1:N ?MAIN_LOOP:S

!
#### 99 bottles

$PAD ?0:N

$ADD ?100:N

>

$PAD ?MAIN_LOOP:S

$SUB ?1:N

$OUT ?L:A

$OUT ?Bottles of beer on the wall:S

$OUT ?L:A

$OUT ?Bottles of milk! You take one down, you pass it around.:S

$JUMP ?L:A ?MAIN_LOOP:S

$OUT No more bottles of beer on the wall, no more bottles of beer.:S
$OUT Go to the store and buy some more, 99 bottles of beer on the wall.:S

!
