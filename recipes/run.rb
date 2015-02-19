template '/tmp/ansible-inventory' do
  source 'inventory.erb'
  variables({
                :host_group => node['ansible']['inventory']['host_group']
            })
end

execute "ansible-playbook -i '/tmp/ansible-inventory' -e #{node['ansible']['vars']} /tmp/ansible-playbooks/#{node['ansible']['playbook']}" do
  action :run
end