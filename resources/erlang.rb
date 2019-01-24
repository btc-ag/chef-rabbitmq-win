property :version, String, name_property: true
property :source, String

action :install do
  parts = new_resource.version.split('.')
  major = parts[0].to_i
  minor = parts[1].to_i
  erl_major = major - 11

  source_url = if property_is_set?(:source)
                  new_resource.source
                else
                  "http://erlang.org/download/otp_win64_#{new_resource.version}.exe"
                end
                
  windows_package "Erlang OTP #{major} (#{erl_major}.#{minor})" do
    source source_url
    installer_type :custom
    options '/S'
  end

  windows_env 'ERLANG_HOME' do
    value "C:\\Program Files\\erl#{erl_major}.#{minor}"
  end
end

action :remove do
  parts = new_resource.version.split('.')
  major = parts[0].to_i
  minor = parts[1].to_i
  erl_major = major - 11

  windows_package "Erlang OTP #{major} (#{erl_major}.#{minor})" do
    action :remove
    installer_type :custom
    options '/S'
  end

  windows_env 'ERLANG_HOME' do
    action :delete
  end

  registry_key 'HKLM\SOFTWARE\Ericsson\Erlang\ErlSrv' do
    recursive true
    action :delete_key
  end
end
