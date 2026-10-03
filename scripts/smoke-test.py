"""Check a running, published demo: python3 scripts/smoke-test.py [base_url]."""
import json, sys, urllib.request
base = (sys.argv[1] if len(sys.argv)>1 else 'http://127.0.0.1:5080').rstrip('/')
def read(route):
    with urllib.request.urlopen(base+route, timeout=10) as response:
        assert response.status==200
        return response.read().decode()
assert json.loads(read('/health'))['status']=='healthy'
info=json.loads(read('/api/info'))
assert info['message'] and info['version']
assert info['framework'].startswith('.NET 10.')
assert '<title>.NET deployment demo</title>' in read('/')
print('PASS: home page, health check, version, message and .NET 10 runtime')
print('Server OS:',info['os'])
print('Version:',info['version'])
