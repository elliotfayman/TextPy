import unittest
from io import StringIO
from contextlib import redirect_stdout
from compiler import Compiler
import subprocess

class TestCompiler(unittest.TestCase):
    def setUp(self):
        self.c = Compiler()

    def test_set_code(self):
        code = 'print("Hello, world!")'
        self.c.set_code(code)
        self.assertEqual(self.c.get_code(), code)

    def test_get_code_empty(self):
        self.assertEqual(self.c.get_code(), '')

    def test_get_output_empty(self):
        self.assertEqual(self.c.get_output(), '')

    def test_set_output(self):
        output = 'Hello, world!'
        self.c.set_output(output)
        self.assertEqual(self.c.get_output(), output)

    def test_compile_success(self):
        code = 'print("Hello, world!")'
        self.c.set_code(code)
        self.c.compile()
        self.assertEqual(self.c.get_output(), 'Hello, world!')

    def test_compile_error(self):
        code = 'foo()'
        self.c.set_code(code)
        self.c.compile()
        self.assertIn('Error:', self.c.get_output())

    def test_compile_exception(self):
        code = '1 / 0'
        self.c.set_code(code)
        self.c.compile()
        self.assertIn('Error:', self.c.get_output())

    def test_compile_large_output(self):
        code = 'print("a" * 1000000)'
        self.c.set_code(code)
        self.c.compile()
        self.assertEqual(len(self.c.get_output()), 1000000)

    def test_compile_stdout(self):
        code = 'print("Hello, world!")'
        self.c.set_code(code)
        with redirect_stdout(StringIO()) as f:
            self.c.compile()
            print("Hello, world!")
            self.assertEqual(f.getvalue().strip(), 'Hello, world!')

    def test_compile_input(self):
        code = 'print(input())'
        self.c.set_code(code)
        with StringIO('Hello, world!\n') as f:
            result = subprocess.run(['python', '-c', self.c.get_code()], input=f.read(), capture_output=True, text=True)
            self.assertEqual(result.stdout.strip(), 'Hello, world!')

    def test_set_get_output(self):
        output = 'Hello, world!'
        self.c.set_output(output)
        self.assertEqual(self.c.get_output(), output)

    def test_compile_syntax_error(self):
        code = 'print('
        self.c.set_code(code)
        self.c.compile()
        self.assertIn("SyntaxError", self.c.get_output())

    def test_compile_divide_by_zero_error(self):
        code = '1/0'
        self.c.set_code(code)
        self.c.compile()
        self.assertIn("ZeroDivisionError", self.c.get_output())

    def test_compile_import_error(self):
        code = 'import non_existent_module'
        self.c.set_code(code)
        self.c.compile()
        self.assertIn("ModuleNotFoundError", self.c.get_output())

    def test_set_get_code(self):
        code = 'print("Hello, world!")'
        self.c.set_code(code)
        self.assertEqual(self.c.get_code(), code)

    def test_set_invalid_code(self):
        code = 'invalid code'
        self.c.set_code(code)
        self.assertEqual(self.c.get_code(), code)

    def test_set_get_output_empty(self):
        output = ''
        self.c.set_output(output)
        self.assertEqual(self.c.get_output(), output)

    def test_compile_invalid_interpreter(self):
        code = 'print("Hello, world!")'
        self.c.set_code(code)
        with self.assertRaises(Exception):
            subprocess.run(['invalid_interpreter', '-c', self.c.get_code()], capture_output=True, text=True)

    def test_compile_long_output(self):
        code = 'print("a" * 1000000)'
        self.c.set_code(code)
        self.c.compile()
        self.assertEqual(len(self.c.get_output().strip()), 1000000)

    def test_compile_long_input(self):
        code = 'print(input())'
        self.c.set_code(code)
        with StringIO('a' * 1000000) as f:
            result = subprocess.run(['python', '-c', self.c.get_code()], input=f.read(), capture_output=True, text=True)
            self.assertEqual(result.stdout.strip(), 'a' * 1000000)


if __name__ == '__main__':
    unittest.main()
