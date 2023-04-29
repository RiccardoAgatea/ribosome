executable :gem do
  command :install
end

executable :rails do
  command :new do
    flag :asset_pipeline
  end
end

gem.install :rails

rails.new project_name do
  asset_pipeline false
end
