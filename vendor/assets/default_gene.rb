define_command :gem_exe do |*args|
  run :gem, *args
end

gem_exe :install, :rails

rails :new, {asset_pipeline: false}, project_name
