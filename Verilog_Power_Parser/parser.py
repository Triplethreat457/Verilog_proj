from lexer import *
from helpparser import * 
# create implicit dictionary to hold local param values only activated if localparam is activated

# Have dictionary hold parameter values in value 



#module declaration, module instantiation if the module name appears without module being the previous keyword then do something. 

class Parser:
    def __init__(self, tokens:list[Token]):
        self.tokens = tokens
        self.current_position:int = 0
        self.plist = { }  # declaring an empty dictionary gonna store the parameter vars and there values will get overwritten
        self.mlist:list[Module] = [ ]

        
    def parse_module(self): # called after seeing an module token 
        ports:list[Port] = [ ]
        self.expect("MODULE")
        self.expect("IDENTIFIER")
        if(self.match("#")):
            self.read_parameter_list()  
        self.expect("RPARENS")    
        

        
        


        # At the end of the parse module it is going to create a list 

    
    def current_token(self):
        if self.current_position < len(tokens):
            return self.tokens[self.current_position]
        else:
            return None
    #read localparam_parameter function 
    def read_parameter_list(self): # Function to read a parameter list only read when it sees token is module identifier hash then call this 
        self.expect("#")
        self.advance()
        self.expect("LPARENS")
        while True:
            temp = ""
            val = self.current_token().lexee
            match(self.current_token().get()):
                case "RPARENS":
                    self.advance()
                    break
                case "IDENTIFIER":
                    temp = val #Stores the varable name in memory
                    self.advance()
                case "NUMBER":
                    self.plist[temp] = val # Next number is stored in dictionary which would be after an equal and identifer would be
                    self.advance()
    def advance(self):
        self.current_position += 1

    def expect(self,Token:str):
        tk = self.current_token()
        if tk.get() != Token:
            self.error(Token)
        else:
            #Process Token 
            self.advance()

    
    def error(self,token:str):
        print(f"Syntax Error:\n\nExpected {token}\nFOUND{self.current_token().get()} (`{self.current_token().lexee}`)")
    def read_bits(self): # Only trigger if I see an braces 
        msb = 0
        lsb = 0
        self.expect("[")
        if(self.match("NUMBER")):
           




    def match(self, token):
        if self.current_token().get() == token:
            return True
        else: 
            return False
    def parse_port_list(self):
        ports:list[Port] = [ ] # Empty Port List 
        is_signed = False
        is_reg = False
        
        while True:
            tk = self.current_token()
            mem:str = "" 

            if self.match("INPUT") or self.match("OUTPUT"):
                is_reg = False # Reset once input or output is seen 
                mem = tk.get()
                is_signed = False
            if self.match("SIGNED"):
                is_signed = True
            if self.match("REG"):
                is_reg = True
            if self.match("IDENTIFIER"):
                Port(mem,tk.lexee,1,is_reg)


            
            
              
                
            
            else:
                if tk.get() == "REG":
                    is_reg = True
                if tk.get() == "IDENTIFIER":
                    Port(mem, tk.lexee, 1)
                

                
                    

                
            
            if tk.get() == "RPARENS":
                break

            
            
            


    


