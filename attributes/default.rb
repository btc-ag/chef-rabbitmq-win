default['rabbitmq-win']['erl-version'] = '24.0'
default['rabbitmq-win']['erl-source'] = "http://erlang.org/download/otp_win64_#{node['rabbitmq-win']['erl-version']}.exe"
default['rabbitmq-win']['version'] = '3.7.10'
default['rabbitmq-win']['source'] = "https://github.com/rabbitmq/rabbitmq-server/releases/download/v#{node['rabbitmq-win']['version']}/rabbitmq-server-#{node['rabbitmq-win']['version']}.exe"
default['rabbitmq-win']['base'] = 'C:\rabbitmq\data'
