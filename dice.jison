%{
	function getRandomInt(min, max) {
		return Math.floor(Math.random() * (max - min + 1)) + min;
	}
%}

/* lexical grammar */
%lex
%%

\s+			/* skip whitespace */
[0-9]+			return 'NUMBER'
"*"				return '*'
"/"				return '/'
"-"				return '-'
"+"				return '+'
"^"				return '^'
"%"				return '%'
"("				return '('
")"				return ')'
[dD]			return 'D'
[hHkK]			return 'H'
[lL]			return 'L'
[fF]			return 'F'
<<EOF>>			return 'EOF'
.				throw "Invalid Input Token!"

/lex

/* operator associations and precedence */

%left '+' '-'
%left '*' '/'
%left '^'
%right '%'
%right 'D' 'H' 'L' 'F'
%left UMINUS

%start expressions

%% /* language grammar */

expressions: 
  e EOF 		{return $1;}
;

e:
  e '+' e		{$$ = $1 + $3;}
| e '-' e		{$$ = $1 - $3;}
| e '*' e		{$$ = $1 * $3;}
| e '/' e		{$$ = $1 / $3;}
| e '^' e		{$$ = Math.pow($1, $3);}
| e '%'	e		{$$ = $1 % $3;}
| '-' e %prec UMINUS	{$$ = -$2;}
| e 'D' e 'H' e		{
	if($3 < 1)  throw "Dice must have at least one side!";
	if($5 < 1)  throw "You must keep at least one die!";
	if($5 > $1) throw "You can't keep more dice than you roll!";
	var rolls = [];
	for(var i = $1; i--;) rolls.push(getRandomInt(1, $3));
	var roll = rolls.sort(function (a, b) {return a - b;}).slice(rolls.length - $5, rolls.length).reduce(function (a, b) {return a + b;});
	console.log("Rolled " + rolls + " = " + roll);
	$$ = roll;
}
| e 'D' e 'L' e		{
	if($3 < 1)  throw "Dice must have at least one side!";
	if($5 < 1)  throw "You must keep at least one die!";
	if($5 > $1) throw "You can't keep more dice than you roll!";
	var rolls = [];
	for(var i = $1; i--;) rolls.push(getRandomInt(1, $3));
	var roll = rolls.sort(function (a, b) {return a - b;}).slice(0, $5).reduce(function (a, b) {return a + b;});
	console.log("Rolled " + rolls + " = " + roll);
	$$ = roll;
}
| e 'D' e		{
	if($3 < 1)  throw "Dice must have at least one side!";
	var rolls = [];
	for(var i = $1; i--;) rolls.push(getRandomInt(1, $3));
	var roll = rolls.reduce(function (a, b) {return a + b;});
	console.log("Rolled " + rolls + " = " + roll);
	$$ = roll;
}
| 'D' e			{
	if($2 < 1)  throw "Dice must have at least one side!";
	var roll = getRandomInt(1, $2);
	console.log("Rolled " + roll);
	$$ = roll;
}
| e 'D' 'F' 'H' e		{
	if($5 < 1)  throw "You must keep at least one die!";
	if($5 > $1) throw "You can't keep more dice than you roll!";
	var rolls = [];
	for(var i = $1; i--;) rolls.push(getRandomInt(-1, 1));
	var roll = rolls.sort(function (a, b) {return a - b;}).slice(rolls.length - $5, rolls.length).reduce(function (a, b) {return a + b;});
	console.log("Rolled " + rolls + " = " + roll);
	$$ = roll;
}
| e 'D' 'F' 'L' e		{
	if($5 < 1)  throw "You must keep at least one die!";
	if($5 > $1) throw "You can't keep more dice than you roll!";
	var rolls = [];
	for(var i = $1; i--;) rolls.push(getRandomInt(-1, 1));
	var roll = rolls.sort(function (a, b) {return a - b;}).slice(0, $5).reduce(function (a, b) {return a + b;});
	console.log("Rolled " + rolls + " = " + roll);
	$$ = roll;
}
| e 'D' 'F'		{
	var rolls = [];
	for(var i = $1; i--;) rolls.push(getRandomInt(-1, 1));
	var roll = rolls.reduce(function (a, b) {return a + b;});
	console.log("Rolled " + rolls + " = " + roll);
	$$ = roll;
}
| 'D' 'F'		{
	var roll = getRandomInt(-1, 1);
	console.log("Rolled " + roll);
	$$ = roll;
}
| '(' e ')'		{$$ = $2;}
| NUMBER		{$$ = Number(yytext);}
| .				{throw "Invalid Input Structure";}
;