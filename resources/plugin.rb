property :pluginName, String, name_property: true

action :install do
  name = 'rabbitmq_' + new_resource.pluginName
  execute "Install RabbitMQ plugin #{name}" do
    command "\"%RABBITMQ_SERVER%\\sbin\\rabbitmq-plugins.bat\" enable #{name}"
    not_if { shell_out('"%RABBITMQ_SERVER%\sbin\rabbitmq-plugins.bat" list --enabled').stdout =~ /#{name}/ }
  end
end

action :remove do
  name = 'rabbitmq_' + new_resource.pluginName
  execute "Remove RabbitMQ plugin #{name}" do
    command "\"%RABBITMQ_SERVER%\\sbin\\rabbitmq-plugins.bat\" disable #{name}"
    only_if { shell_out('"%RABBITMQ_SERVER%\sbin\rabbitmq-plugins.bat" list --enabled').stdout =~ /#{name}/ }
  end
end
