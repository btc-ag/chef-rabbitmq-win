
rabbitmq_win_erlang node['rabbitmq-win']['erl-version'] do
  action :install
  source node['rabbitmq-win']['erl-source']
end

rabbitmq_win node['rabbitmq-win']['version'] do
  action :install
  base node['rabbitmq-win']['base']
  source node['rabbitmq-win']['source']
end

rabbitmq_win_plugin 'management'
