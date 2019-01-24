property :version, String, name_property: true
property :base, String, default: ''
property :source, String

action :install do
  base = new_resource.base.strip
  if base != ''
    windows_env 'RABBITMQ_BASE' do
      value base
    end
  end

  source_url = if property_is_set?(:source)
                 new_resource.source
               else
                 "https://github.com/rabbitmq/rabbitmq-server/releases/download/v#{new_resource.version}/rabbitmq-server-#{new_resource.version}.exe"
               end

  windows_package "RabbitMQ Server #{new_resource.version}" do
    source source_url
    installer_type :custom
    options '/S'
  end
  path = 'C:\Program Files\RabbitMQ Server\rabbitmq_server-' + new_resource.version
  windows_env 'RABBITMQ_SERVER' do
    value path
  end

  windows_path '%RABBITMQ_SERVER%\sbin'
end

action :remove do
  path = 'C:\Program Files\RabbitMQ Server\rabbitmq_server-' + new_resource.version + '\sbin\rabbitmq-service.bat'
  execute 'Stopping service' do
    command "\"#{path}\" stop"
    only_if { ::File.exist?(path) }
    returns [0, 1]
  end

  execute 'Removing service' do
    command "\"#{path}\" remove"
    only_if { ::File.exist?(path) }
    returns [0, 1]
  end

  windows_path '%RABBITMQ_SERVER%\sbin' do
    action :remove
  end

  windows_env 'RABBITMQ_SERVER' do
    action :delete
  end

  windows_env 'RABBITMQ_BASE' do
    action :delete
  end

  windows_package "RabbitMQ Server #{new_resource.version}" do
    action :remove
    installer_type :custom
    options '/S'
  end
end
