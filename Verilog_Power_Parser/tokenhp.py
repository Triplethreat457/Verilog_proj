tokens = []
class Token:
    def __init__(self, token, lexee):
        self.token = token
        self.lexee = lexee
        tokens.append(self)
    def print_token(self):
        print(f"{self.token:<20}{self.lexee}")

    def get(self):
        return self.token
    