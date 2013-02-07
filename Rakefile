directory 'target'

# Export path for boxes
def target(box)
   return "output/#{box}.box"
end

boxes = [
  'apache2_precise64', 'nginx_precise64',
  'elasticsearch_precise64', 'mongodb_precise64', 'mysql_precise64', 'neo4j_precise64', 'postgres_precise64',
  'hadoop_precise64',  'hadoop2_precise64', 'zookeeper_precise64',
  'r_precise64', 'sage_precise64', 'vowpalwabbit_precise64',
  'boxgrinder_precise64', 'dev_precise64'
]

puppetfiles = FileList['modules/**/*']



################################################################################
# Build Tasks
################################################################################

task :default => boxes.map { |box| target(box) }

task :clean do
  sh 'vagrant destroy -f'
  boxes.each do |box|
    sh "vagrant box remove #{box} || true"
  end
  sh 'rm -fr output/*.box'
end

boxes.each do |box|
  # Target for exporting a box is the destination location in target/
  file target(box) do
    sh "vagrant destroy -f #{box}"
    sh "vagrant box remove #{box} || true"
    sh "vagrant up #{box}"
    sh "vagrant package #{box} --output #{target(box)}"
    sh "vagrant destroy -f #{box}"
  end
end

task :lint do
  sh 'puppet-lint --with-filename modules'
end


################################################################################
# TODO: Tests
################################################################################
