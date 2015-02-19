template '/tmp/ansible-inventory' do
  source 'inventory.erb'
  variables({
                :host_group => node['ansible']['inventory']['host_group']
            })
end

template '/tmp/ansible-variables' do
  source 'variables.erb'
  variables({
                :vars => node['ansible']['vars']
            })
end

execute "ansible-playbook -i '/tmp/ansible-inventory' -e '@ansible-variables' /tmp/ansible-playbooks/#{node['ansible']['playbook']}" do
  cwd '/tmp'
  action :run
end