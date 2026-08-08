from helperlex import *




predetermined_path = "/Users/triplethreat457/Personal_Projects_v/Verilog_Power_Parser/"
filename = input("Give me the verilog file you want to process, should be a .v file:\n")
actual_path = predetermined_path + filename




created_path = predetermined_path + filename


     
        
class lexer:
    def run(self, created_path):
        with open(created_path, "r") as file:
            read_string = file.read()
            # with open("output.txt", "w") as os:
            #     os.write(read_string)
            if final:
                print(f"{"TOKEN":<20}LEXEME")
                print(f"------------------------------------")

            cursor = 0

            total_characters = len(read_string)
            while True:
                if cursor >= total_characters:
                    break
                else: 
                    cursor = no_whitespace(cursor, read_string)
                    
                    
                    # if (read_string[cursor] in Token_names):
                    #     if(peek(read_string[cursor] in Token_names)):
                    if cursor >= total_characters:
                        break
                    char = read_string[cursor]
                    
                    print()
                    if(char in peek_chars):
                        cursor = read_operator(cursor, read_string)
                    elif(char.isdigit()):
                        cursor = read_number(cursor,read_string)
                    elif(char in Token_names):
                        print_token(char)
                        cursor = cursor + 1   
                    
                    else:
                        word_r , cursor = read_word(cursor, read_string)
                        if word_r in {"module", "endmodule", "always", "begin", "end"}:
                            print()
                        print_token(word_r)
                        
            if final:
                print("\n")
                print("EOF")                                  
                    
                    
                    
if __name__ == '__main__':
    lexer_1 = lexer()
    lexer_1.run(actual_path)
    # for tk in tokens:
    #     tk.print_token()
    

          



