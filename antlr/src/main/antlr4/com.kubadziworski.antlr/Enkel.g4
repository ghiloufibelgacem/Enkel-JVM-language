//header
grammar Enkel;

//RULES
compilationUnit : classDeclaration EOF ;
classDeclaration : className '{' classBody '}' ;
className : ID ;
classBody :  function* ;
function : functionDeclaration block ;
functionDeclaration : (type)? functionName '('? (functionParameter (',' functionParameter)*)? ')'? ;
functionName : ID ;
functionParameter : type ID functionParamdefaultValue? ;
functionParamdefaultValue : '=' expression ;
type : primitiveType
     | classType ;

primitiveType :  'boolean' ('[' ']')*
                |   'string' ('[' ']')*
                |   'char' ('[' ']')*
                |   'byte' ('[' ']')*
                |   'short' ('[' ']')*
                |   'int' ('[' ']')*
                |   'long' ('[' ']')*
                |   'float' ('[' ']')*
                |  'double' ('[' ']')*
                | 'void' ('[' ']')* ;
classType : QUALIFIED_NAME ('[' ']')* ;

block : '{' statement* '}' ;

statement : block
           | variableDeclaration
           | printStatement
           | functionCall
           | returnStatement
           | ifStatement ;

variableDeclaration : VARIABLE name EQUALS expression;
printStatement : PRINT expression ;
returnStatement : ('return')? expression #RETURNWITHVALUE
                | 'return' #RETURNVOID ;
functionCall : functionName '('expressionList ')';
ifStatement :  'if'  ('(')? expression (')')? trueStatement=statement ('else' falseStatement=statement)?;
name : ID ;
expressionList : expression? (',' expression)* ;
expression : varReference #VARREFERENCE
           | value        #VALUE
           | functionCall #FUNCALL
           |  '('expression '*' expression')' #MULTIPLY
           | expression '*' expression  #MULTIPLY
           | '(' expression '/' expression ')' #DIVIDE
           | expression '/' expression #DIVIDE
           | '(' expression '+' expression ')' #ADD
           | expression '+' expression #ADD
           | '(' expression '-' expression ')' #SUBSTRACT
           | expression '-' expression #SUBSTRACT
           | expression cmp='>' expression #conditionalExpression
             | expression cmp='<' expression #conditionalExpression
             | expression cmp='==' expression #conditionalExpression
             | expression cmp='!=' expression #conditionalExpression
             | expression cmp='>=' expression #conditionalExpression
             | expression cmp='<=' expression #conditionalExpression
           ;
varReference : ID ;
value : NUMBER
      | STRING ;
//TOKENS
VARIABLE : 'var' ;
PRINT : 'print' ;
EQUALS : '=' ;
NUMBER : [0-9]+ ;
STRING : '"'~('\r' | '\n' | '"')*'"' ;
ID : [a-zA-Z0-9]+ ;
QUALIFIED_NAME : ID ('.' ID)+;
WS: [ \t\n\r]+ -> skip ;