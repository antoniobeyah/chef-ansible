apt_repository 'ansible' do
  uri 'ppa:ansible/ansible'
  distribution node['lsb']['codename']
end

package 'ansible' do
  version node['ansible']['version']
  action :install
end