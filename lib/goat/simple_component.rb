
module Goat
  class SimpleComponent < Component

    DEFAULT_PROJECT_NAME = "new_simple_project"
    DIRECTORIES = ['bin','lib','test','spec','ext']

    def initialize(project_name=DEFAULT_PROJECT_NAME)
      @project_name=project_name
      @directories = ['bin','lib','test','spec','ext']
      @working_dir = "#{Dir.pwd}/#{@project_name}"
    end

    def pre_setup
      puts "attempting to create project directory #{@working_dir}"
      if File.exists?(@working_dir)
        puts "project directory already exists.  exiting. . ."
        exit 1
      end
    end

    def setup
     
    end

    def build
      Dir.mkdir(@working_dir)

      DIRECTORIES.each do |directory_name|
        directory_to_create = "#{@working_dir}/#{directory_name}"
        Dir.mkdir(directory_to_create) unless File.exists? directory_to_create
      end

      #create Gemfile
      file = File.open "#{@working_dir}/Gemfile", "wb"
      file.write gem_file_contents

      #create Rakefile
      file = File.open "#{@working_dir}/Rakefile", "wb"
      file.write rake_file_contents

      #create LICENSE
      file = File.open "#{@working_dir}/LICENSE", "wb"

      #create README
      file = File.open "#{@working_dir}/README", "wb"

      #create exe
      file = File.open "#{@working_dir}/bin/sample_main", "wb"
      file.write sample_main_contents

      #create src folder
      file = File.open "#{@working_dir}/lib/#{@project_name}.rb", "wb"
      file.write lib_root_file_contents

      Dir.mkdir("#{@working_dir}/lib/#{@project_name}")
      file = File.open "#{@working_dir}/lib/#{@project_name}/sample.rb", "wb"

      

      #create spec

      #create unittest


      #TODO: create C extension
    end

    def finalize
      
    end

    def cleanup
      puts "successfully created a SimpleComponent project: #{@project_name}"
    end

    private
    def lib_root_file_contents
      "require '#{@project_name}/sample'

module #{@project_name}

end"
    end

    def sample_main_contents
      "#!/usr/bin/env ruby

#require '#{@project_name}'

#hello_worlder = new HelloWorld.new
#hello_worlder.speak"
    end
    
    def gem_file_contents
      "gem 'rspec'"
    end


    def rake_file_contents
      "require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'
require 'rspec/core/rake_task'

spec = Gem::Specification.new do |s|
  s.name = '#{@project_name}'
  s.version = '0.0.1'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README', 'LICENSE']
  s.summary = 'Your summary here'
  s.description = s.summary
  s.author = ''
  s.email = ''
  s.executables = ['sample_main']
  s.files = %w(LICENSE README Rakefile) + Dir.glob(\"{bin,lib,spec}/**/*\")
  s.require_path = 'lib'
  s.bindir = 'bin'
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

Rake::RDocTask.new do |rdoc|
  files =['README', 'LICENSE', 'lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = 'README' # page to start on
  rdoc.title = '#{@project_name} Docs'
  rdoc.rdoc_dir = 'doc/rdoc' # rdoc output folder
  rdoc.options << '--line-numbers'
end

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb']
end

RSpec::Core::RakeTask.new(:spec)"
    end



  end

end
