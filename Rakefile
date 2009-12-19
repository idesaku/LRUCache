require 'rubygems'
gem 'rspec', '~>1.2.9'
gem 'rcov'
require 'spec/rake/spectask'
require 'spec/rake/verify_rcov'

task 'default' => 'spec'

Spec::Rake::SpecTask.new do |t|
  t.fail_on_error = false
  t.spec_opts = ['--color', '--format', 'p']
  t.rcov = true
  t.rcov_opts = %w(--exclude spec)
end

RCov::VerifyTask.new(:verify_rcov => 'spec') do |t|
    t.threshold = 100.0
    t.index_html = 'coverage/index.html'
end
