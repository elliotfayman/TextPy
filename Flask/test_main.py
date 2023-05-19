import unittest
from unittest.mock import patch
from flask import url_for
from main import app

class TestFlaskApp(unittest.TestCase):

    def setUp(self):
        app.config['TESTING'] = True
        self.app = app.test_client()

    #def test_homepage(self):
        #response = self.app.get('/')
       # self.assertEqual(response.status_code, 200)
       # self.assertIn(b'<h1>Welcome to the Python Compiler</h1>', response.data)

    def test_test(self):
        response = self.app.get('/test')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'{"code":200,"message":"Server contacted. Connection successful"}', response.data)

    def test_compile_code(self):
        code = 'print("Hello, world!")'
        with patch('main.compiler') as mock_compiler:
            mock_compiler.get_output.return_value = 'Hello, world!\n'
            response = self.app.post('/compile', data=dict(code=code))
            self.assertEqual(response.status_code, 200)
            self.assertIn(b'{"code":200,"message":"Hello, world!\\n"}', response.data)


