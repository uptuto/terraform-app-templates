import yaml
import json
import sys

try:
    with open('apps.yaml') as f:
        apps = yaml.safe_load(f)['apps']
except Exception as e:
    print(f'Failed to load apps.yaml: {e}')
    sys.exit(1)

for app in apps:
    path = f'terraform/vars/{app["app_name"]}.auto.tfvars.json'
    print(f'Writing {path}')
    with open(path, 'w') as tfvar_file:
        json.dump(app, tfvar_file)
