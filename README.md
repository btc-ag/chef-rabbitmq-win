# RabbitMQ Windows cookbook

[![Build Status](https://dev.azure.com/btcag-chef/rabbitmq-win/_apis/build/status/btc-ag.chef-rabbitmq-win?branchName=master)](https://dev.azure.com/btcag-chef/rabbitmq-win/_build/latest?definitionId=1?branchName=master)

This cookbook can be used to install erlang and RabbitMQ on Windows nodes

## Simple usage

Define the variables 

```ruby
default['rabbitmq-win']['erl-version'] = '21.2'
default['rabbitmq-win']['version'] = '3.7.10'
default['rabbitmq-win']['base'] = ''
```
and include the `rabbitmq_win::default` recipe. This will install erlang, set the ERLANG_HOME variable, install rabbitmq, start the service and install rabbit mq management console. 
If the `base` variable is left empty, RabbitMQ will use a path in the users home directory. You should set this variable for servers.

## Usage with wrapper cookbooks

The cookbook defines two resources, `rabbitmq_win_erlang` and `rabbit_mq_win`.

Usage example to install RabbitMQ:

```ruby
rabbitmq_win_erlang "21.2" do
  action :install
end

rabbitmq_win "3.7.10" do
  action :install
  base 'C:\rabbitmq\data'
end

rabbitmq_win_plugin 'management'
```

Example to remove a plugin

```ruby
rabbitmq_win_plugin 'mqtt' do
  action :remove
end
```

Usage example to remove RabbitMQ:
```ruby
rabbitmq_win "3.7.10" do
  action :remove
end

rabbitmq_win_erlang "21.2" do
  action :remove
end
```