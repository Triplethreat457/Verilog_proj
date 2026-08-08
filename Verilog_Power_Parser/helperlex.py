from tokenhp import *

peek_chars = {
    '<',
    '>',
    '=',
    '!',
    '&',
    '|',
    '^',
    '~',
    '/'
}
final = False 
while final == False:
    sel = input("Do you want to print out the Token List? (y/n): ")
    if sel.lower() == "y" or sel.lower() == "n":
        if sel.lower() == "y":
            final = True
        break


Token_names = {
    # Delimiters
    "(": "LPARENS",
    ")": "RPARENS",
    "[": "LBRACKET",
    "]": "RBRACKET",
    ":": "COLON",
    "#": "HASH",
    ";": "SEMICOLON",
    ",":"COMMA",
    "'" :"APOSTROPHE",
    "@": "AT",
    #Lexers ignore comments 


    # Keywords
    "assign": "ASSIGN",
    "module": "MODULE",
    "assign": "ASSIGN",
    "output": "OUTPUT",
    "inout":"INOUT",
    "input": "INPUT",
    "wire": "WIRE",
    "reg": "REG",
    "always": "ALWAYS",
    "begin": "BEGIN",
    "end": "END",
    "parameter": "PARAMETER",
    "localparam": "LOCALPARAM",
    "integer": "INTEGER",
    "endmodule": "ENDMODULE",
    "number": "NUMBER",
    "$display" : "DISPLAY",
    "generate": "GENERATE",
    "genvar": "GENVAR",
    "endgenerate":"ENDGENERATE",
    "case": "CASE",
    "endcase":"ENDCASE",
    "initial":"INITIAL",
    "if": "IF",
    "else": "ELSE",
    "task": "TASK",
    "endtask": "ENDTASK",
    



    # Operators
    "&": "BIT_AND",
    "|": "BIT_OR",
    "^": "BIT_XOR",
    "~^": "BIT_XNOR",
    "^~": "BIT_XNOR",
    "~": "BIT_NOT",
    "=": "ASSIGN_OP",
    "&&": "LOGICAL_AND",
    "||": "LOGICAL_OR",
    "!": "LOGICAL_NOT",
    "<": "LESS_THAN", 
    "<<": "SHIFT_LEFT",
    ">": "GREATER_THAN",
    "<=":"LESS_EQUAL",
    ">=":"GREATER_EQUAL",
    "==": "EQUAL",
    "!=": "NOT_EQUAL",
    "===":"CASE_EQUAL",
    "!==":"CASE_NOT_EQUAL",
    ">>": "SHIFT_RIGHT",
    "+": "PLUS",
    "-": "MINUS",
    "*": "STAR",
    "/": "DIVIDE",
    "?": "TENERY",
    "%":"MODULO"

    
}

def read_word(current_cursor, string):
    word = "" #word is set to an empty string 
    stop_chars = {"(", ")", "[", "]", ";", ",", ":", "&", 
                  "|", "^", "<", "=", "+", "-", "*","#", "\n", " ", "\t", 
                  "\r", ">", "?", "!","%", "'"}
    
    while(current_cursor < len(string)
           and (string[current_cursor] not in  stop_chars)):
        word += string[current_cursor]
        current_cursor += 1
    return word , current_cursor 
# By the end of reading a word the cursor whould be one space after word itself

def no_whitespace(index, string):
    set = {" ", "\n", "\t"}
    while(index < len(string) and (string[index] in set)) :  
        index  = index + 1 
    return index
def peek(cursor, string): # function to check if the next word is < or >  # priority first 
    return (string[cursor + 1] if cursor + 1 < len(string) else "")

def last_character(word): # function to check if the last character is , or ;  #Priority second
    return word[len(word) - 1]

def print_token(lexee): #function to print the token format 
    if lexee not in Token_names:
        print_identifier(lexee)
    else: 
        if final:
            print(f"{Token_names.get(lexee):<20}{lexee}")
        token_1 = Token(Token_names.get(lexee),lexee)

def print_identifier(identifier):
    word = "IDENTIFIER"
    if final:
        print(f"{word:<20}{identifier}")
    token_1 = Token("IDENTIFIER", identifier)
def read_number(cursor, read_s): #Code to read number and print to terminal
    idx = cursor
    if(cursor < len(read_s) and read_s[cursor].isdigit()):
        word, idx = read_word(cursor, read_s)
        if(idx < len(read_s) and read_s[idx] == "'"):
            place = read_s[idx]
            word_2, idx = read_word(idx + 1, read_s)
            full_numb  = word + place + word_2
            print(f"{"NUMBER":<20}{full_numb}")
            token = Token("NUMBER", full_numb)
            
        else:
            print(f"{"NUMBER":<20}{word}")
            token = Token("NUMBER", word)

    return idx 
        
def read_operator(cursor, string):
    full_string = string[cursor: cursor + 3] 
    half_string = string[cursor:cursor + 2]
    # Comment Case
    if string[cursor:cursor + 2] == "/*":
        op = skip_until(cursor, string)
    elif  string[cursor:cursor + 2] == "//":
        op = skip(cursor, string)    
    else:   # No comments
        if(full_string in Token_names):
          
            print_token(full_string)
            op =  cursor + len(full_string)
        else: 
            if(half_string in Token_names):
                print_token(half_string)
                op = cursor + len(half_string)
            else:
                print_token(string[cursor])
                op = cursor + 1 
    return op
def skip(cursor, string): # skip for single line comments 
    op = cursor
    while cursor < len(string):
        if(string[op] == "\n"):
            break   
        else:   
            op += 1 
    return op
def skip_until(cursor , string): # skip for multi block comments 
    op = cursor
    while op < len(string):
        if(string[op] == "*" and peek(op, string) == "/" ):
            op += 2
            break
        else:
            op += 1 
    return op
    