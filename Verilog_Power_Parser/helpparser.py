class Port:
    
    def __init__(self, direction, name, width, is_reg = False, is_signed = False):
        self.direction = direction
        self.name = name
        self.width = width # suggesting doing some arithmetic account for indexing later
        self.is_reg = is_reg

    

class Module:

    def __init__(self, name, ports:list[Port], body):
        self.name = name
        self.ports:list[Port] = ports
        self.body = body

    def insert_port(self, P:Port):
        self.ports.append(P) #simply appends the port to the end 
        


class Assignment:
    def __init__(self, output, operation, operands):
        self.output = output
        self.operation = operation
        self.operands = operands

class Wire:
    def __init__(self, name):
        self.name = name
class Identifier:
    def  __init__(self, name):
        self.name = name



    
