include_recipe "rvm"
include_recipe "rvm::user"

users_manage "eng" do
  group_id 2400
  action [ :remove, :create ]
end

#node['users'].each do |u|
u = "vagrant"
  venv_dir = "/home/" + u + "/" + node["ee-dev-vagrant"]["venv_dir"]

  rvm_ruby "ruby-1.9.3-p392" do
    action :install
    user u
  end

  rvm_gemset "ruby-1.9.3-p392@evt-transform" do
    action :create
    user u
  end

  directory venv_dir do
    owner u
    group u
    recursive true
    mode 0775
  end

  python_virtualenv venv_dir do
    interpreter "python2.7"
    owner u
    group u
    action :create
  end

  python_pip "django" do
    version "1.5.1"
    virtualenv venv_dir
    action :install
  end


#end
