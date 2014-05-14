define :wp_core_install do
  missing = []
  [:url, :title, :admin_user, :admin_password, :admin_email, :dir].each do |required|
    if params[required].nil?
      missing.push(required.to_s)
    end
  end
  raise "WP Core install is missing required parameter(s): #{missing.join(', ')}" if !missing.empty?

  execute "install site" do
    cwd params[:dir]
    command "wp core install --url=#{params[:url]} " +
            "--title='#{params[:title]}' --admin_user=#{params[:admin_user]} " +
            "--admin_password=#{params[:admin_password]} --admin_email=#{params[:admin_email]}"
    not_if "mysql -u root -D #{node['wordpress']['db']['database']} " +
           "-p#{node['mysql']['server_root_password']} " +
           "-e 'DESCRIBE #{node['wordpress']['db']['prefix']}users;'"
  end
end

define :wp_activate do
  log "Activating #{params[:type]} #{params[:name]}"
  execute "activate #{params[:type]}" do
    cwd node['wp_scaffold']['dir']
    command "wp #{params[:type]} activate #{params[:name]}"
    only_if do FileTest.directory?("#{node['wp_scaffold']['dir']}/wp-content/#{params[:type]}s/#{params[:name]}") end
  end
end