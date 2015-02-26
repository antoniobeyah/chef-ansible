ruby_block 'download the playbook from s3' do
  block do
    require 'aws-sdk'

    s3 = nil
    access_key = node['ansible']['aws_access_key']
    secret_key = node['ansible']['aws_secret_key']
    bucket = node['ansible']['bucket']
    remote_path = "#{node['ansible']['path']}/#{node['ansible']['playbook_archive']}"
    target_file = "/tmp/#{node['ansible']['playbook_archive']}"

    if access_key && secret_key
      s3 = ::AWS::S3.new(
        access_key_id: access_key,
        secret_access_key: secret_key
      )
    else
      s3 = ::AWS::S3.new
    end

    bucket = s3.buckets[bucket]
    playbook = bucket.objects[remote_path]

    File.open(target_file, 'wb') do |file|
      playbook.read do |chunk|
        file.write(chunk)
      end
    end
  end

  action :run
end

#s3_file "/tmp/#{node['ansible']['playbook_archive']}" do
#  bucket node['ansible']['bucket']
#  remote_path "#{node['ansible']['path']}/#{node['ansible']['playbook_archive']}"
#  aws_access_key_id node['ansible']['aws_access_key']
#  aws_secret_access_key node['ansible']['aws_secret_key']
#end

directory '/tmp/ansible-playbooks' do
  action :create
end

execute 'extract playbooks' do
  command "tar xzvf /tmp/#{node['ansible']['playbook_archive']} -C /tmp/ansible-playbooks/"
end
