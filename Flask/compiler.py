import subprocess

"""
A class representing a code compiler.

Attributes:
    _code (str): The code to be compiled.
    _output (str): The compiled output.

Methods:
    __init__(self, code): Initializes the Compiler object with the provided code.
    get_code(self): Returns the current code.
    set_code(self, code): Sets the code to be compiled.
    get_output(self): Returns the compiled output.
    set_output(self, output): Sets the compiled output.
    compile(self): Compiles the code using a Python interpreter.

Example Usage:
    >>> c = Compiler('print("Hello, world!")')
    >>> c.compile()
    >>> print(c.get_output())
    'Hello, world!'
"""

class Compiler:

    """
    Initializes the Compiler object with the provided code.

    Args:
        code (str): The code to be compiled.
    """
    def __init__(self):
        self._code = ''
        self._output = ''
    

    """
    Sets the code to be compiled.

    Args:
        code (str): The code to be compiled.
    """
    def set_code(self, code):
        self._code = code
    

    """
    Returns the current code.

    Returns:
        str: The current code.
    """
    def get_code(self):
        return self._code
    

    """
    Sets the compiled output.

    Args:
        output (str): The compiled output.
    """
    def set_output(self, output):
        self._output = output
    

    """
    Returns the compiled output.

    Returns:
        str: The compiled output.
    """
    def get_output(self):
        return self._output
    

    """
    Compiles the code using a Python interpreter.
    
    Throws:
        Exception: If the code cannot be compiled.
    """
    def compile(self):
        try:
            result = subprocess.run(['python', '-c', self._code], capture_output=True, text=True)
            if result.returncode == 0:
                self._output = result.stdout.strip()
            else:
                self._output = f"Error: {result.stderr.strip()}"
        except Exception as e:
            self._output = f"Error: {e}"
