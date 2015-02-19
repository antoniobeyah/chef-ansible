s3_file "/tmp/#{node['ansible']['playbook_archive']}" do
  bucket node['ansible']['bucket']
  remote_path "#{node['ansible']['path']}/#{node['ansible']['playbook_archive']}"
  aws_access_key_id node['ansible']['aws_access_key']
  aws_secret_access_key node['ansible']['aws_secret_key']
end

directory '/tmp/ansible-playbooks' do
  action :create
end

execute 'extract playbooks' do
  command "tar xzvf /tmp/#{node['ansible']['playbook_archive']} -C /tmp/ansible-playbooks/"
end