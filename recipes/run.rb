template '/tmp/ansible-inventory' do
  source 'inventory.erb'
  variables({
                :host_group => node['ansible']['inventory']['host_group']
            })
end

file '/tmp/ansible-vars' do
  content node['ansible']['vars']
end

execute "ansible-playbook -i '/tmp/ansible-inventory' -e '@ansible-vars' /tmp/ansible-playbooks/#{node['ansible']['playbook']}" do
  cwd '/tmp'
  action :run
end