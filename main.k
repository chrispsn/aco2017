// Advent 2017
/ See also https://github.com/mkst/aoc/tree/master/2017


/ Problem 1

input:(*0:`input1)-"0"
1049~+/{(:/x)=':x}#input
1508~{2*+/(*x)@&=/x:2 0N#x}input


/ Problem 2

input:`I$"\t"\'0:`input2
36174~+/-/(|/';&/')@\:input
244~+/_{%/{x@>x}@*(!/')_+x@&~=#x}'input


/ Problem 3

input:`I$*0:`input3
moves:(1 0;0 1;-1 0;0 -1)
path:{+\moves@4!&+\x#1 0}                   / or +\~2!!:

430~+/{x|-x}path[1500]input-2               / 1500 is just a big number

seed:(,0 0)!1
next:{x,(,y)!+/(. x)@&3>+/'{x*x}y-/:!x}
312453~a 1+(a:.seed next/path 20)'input     / 20 is just a big number
/ ^ could use bin search on a dict?


/ Problem 4

input:0:`input4
466~+/{x~'?'x}@" "\'input
251~+/{x~'?'x}@{x@<x}''" "\'input


/ Problem 5

input:`I$0:`input5
while:{x~0|y&x@:1}[;-1+#input]
/ while:{</x[1]<0,y}[;#input]    / alt via ngn

next:{(@[x;y;1+];y+x y;z+1)}.
375042~ :/while next/(input;0;0)

next:{(@[x;y;(-1 1@3>x y)+];y+x y;z+1)}.
/ works, but slow. disabled
/ 28707598~ :/while next/(input;0;0)


/ Problem 6

input:`I$"\t"\*0:`input6

seen:!0
while:{^seen?10/x}
next:{seen,:10/x
      x[i:x?m:|/x]:0
      @[x;(#x)!1+i+!m;1+]}
iters: while next\input
/ scan can't see prior iterations, so we store them in `seen`.
/ ideally would use over, not scan, and reuse `seen` instead

3156~b:#seen
1610~b-iters? :/iters


/ Problem 7

input:0:`input7
input:{(0,x?" )")_x}'input
input:0 2 5_/:'+input
input:@[input;2;", "\']
input:@[input;2;{$[x~,"";();x]}']
input:``I`$input

input:`base`weight`holding!input
`svugo~*(input`base)^,/input`holding

input:(*input)!+1_input
/ given a row, return weights of what it holds
cumweights:{(x`weight)+/o'input x`holding}'input
a:{1<#'?'cumweights[+x;`holding]}#.input
a:+{(input[x`holding;`weight]-f-&/f;f:cumweights x`holding)}'a
1152~{x[i;(~-/&/\y@i:*<&/'y)?0]}/a


/ Problem 8

input:0:`input8
input:`reg`op`arg`drop`condreg`comp`condarg!```I````I$+" "\'input

comps:(`">";`"<";`"==";`">=";`"<=";`"!=")!(>;<;=;~<;~>;~=)
input[`comp]:comps@input`comp

state:(?,/input`reg`condreg)!0    / ? only for performance
process:{@[x;y`reg;(-;+)`inc=y`op;(y`comp)[x@y`condreg;y`condarg]*y`arg]}

3880~|/state process/+input
5035~|/|/'state process\+input


/ Problem 9

input:*0:`input9

/ Approach 1: masks

f:{x[&skip:|':<\"!"=x]:" "
   x[&trash:&':(1&+)\-1+1^"> <"?x]:" "
   (+/a*0>':a:+\-/"{}"=\:x
    +/trash&~skip)}

(11846;6285)~f input

/ Approach 2: tokenise by lookup
/ See eg http://nsl.com/k9/sql.k

char:       "<>{}!"   
sm:"BETS "!("T BE  "  / Begin group
            "  BE  "  / End   group
            "T TTST"  / Trash
            "TTTTTT"  / Skip
            "T BE  ") / Null

g:{tokens:(#char)^char?x
   states:" "sm[;]\tokens
   (+/a*0>':a:+\-/"BE"=\:states    / alt: -1+1^"E B"?states
    +/"T"=&':states)}

(11846;6285)~g input


/ Problem 10

input:*0:`input10
keys:`list`offset`skip
seed:keys!(!256;0;0)

input1:`I$","\input
next:{keys!(@[x`list;i;:;|x[`list;i:(#x`list)!(x`offset)+!y]]
            (#x`list)!y+/x`offset`skip
            1+x`skip)}
3770~*/2#*seed next/input1

input2:(`i$input),17 31 73 47 23
padzeroes:{(x-#y)(0,)/y}
hexify:"0123456789abcdef"padzeroes[2]@16\
output:64 next/[;input2]/seed
a:,/(hexify@2/(~=)/padzeroes[8]'2\')'0N 16#*output
a~"a9d0e68649d0174c8756a59ba21d4dc6"


\\
