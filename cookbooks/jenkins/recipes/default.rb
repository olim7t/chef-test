# Installs Jenkins on an Ubuntu box

include_recipe "java"

apt_repository "jenkins" do
  uri "http://pkg.jenkins-ci.org/debian"
  components ["binary/"]
  key "http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key"
  action :add
end

package "jenkins" do
  version node["jenkins"]["version"]
  action :install
end
