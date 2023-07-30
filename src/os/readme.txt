# CAOSLang
## Declaration
### Values
There are 3 value types: Number (N), Address (A) and String (S)

There are two pools, Live (L) and Alpha (A)

Live - opperative location
Alpha - reserve pool
## Jumping
To jump to a line run $JUMP ?(VALUE:TYPE) ?(LINE):N

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

## Other features
to halt execution run !
## Examples
#### Dubbler
$PAD ?0:N

$ADD ?2:N

$PAD ?1:N

$ADD ?L:A

$OUT ?L:A

$JUMP ?1:N ?1:N

!
#### 99 bottles

$PAD ?0:N

$ADD ?100:N

>

$PAD ?1:N

$SUB ?1:N

$OUT ?L:A

$OUT ?Bottles of beer on the wall:S

$OUT ?L:A

$OUT ?Bottles of milk! You take one down, you pass it around.:S

$JUMP ?L:A ?1:N

$OUT No more bottles of beer on the wall, no more bottles of beer.:S
$OUT Go to the store and buy some more, 99 bottles of beer on the wall.:S

!
