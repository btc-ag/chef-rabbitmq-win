property :version, String, name_property: true
property :source, String
property :overrideErlangHome, String


action :install do
  parts = new_resource.version.split('.')
  major = parts[0].to_i
  minor = parts[1].to_i
  if major >= 22 and major < 23
    erl_major = new_resource.version.to_i - 11.6
  else 
    erl_major = major - 11  
  end 
  pfad = ""
 
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
  
  if new_resource.overrideErlangHome.nil?  
      if major >= 22 and major < 23    
        pfad = "C:\\Program Files\\erl#{erl_major}"
      elsif major >= 23
        pfad = "C:\\Program Files\\erl-#{new_resource.version}"
      elsif major <=21 
        pfad= "C:\\Program Files\\erl#{erl_major}.#{minor}"
      end
  else
    pfad = new_resource.overrideErlangHome
  end
  windows_env 'ERLANG_HOME' do
    value pfad
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
