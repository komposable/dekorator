# frozen_string_literal: true

module GeneratorTestHelpers
  APP_NAME = "dummy_app"

  def remove_project_directory
    FileUtils.rm_rf(project_path)
  end

  def create_tmp_directory
    FileUtils.mkdir_p(tmp_path)
  end

  def remove_decorators_directory
    FileUtils.rm_rf(decorators_path)
    FileUtils.rm_rf(decorators_spec_path)
    FileUtils.rm_rf(decorators_test_path)
  end

  def with_app
    remove_project_directory
    rails_new

    yield
  end

  def rails_new
    run_in_tmp do
      debug `#{system_rails_bin} new #{APP_NAME} --skip-webpack-install`

      Dir.chdir(APP_NAME) do
        File.open("Gemfile", "a") do |file|
          file.puts %{gem "dekorator", path: #{root_path.inspect}}
        end
      end
    end
  end

  def generate(generator)
    run_in_project do
      debug `bin/spring stop`
      debug `#{project_rails_bin} generate #{generator}`
    end
  end

  def destroy(generator)
    run_in_project do
      `bin/spring stop`
      `#{project_rails_bin} destroy #{generator}`
    end
  end

  def project_path
    @project_path ||= Pathname.new("#{tmp_path}/#{APP_NAME}")
  end

  def decorators_path
    @decorators_path ||= Pathname.new("#{tmp_path}/#{APP_NAME}/app/decorators")
  end

  def decorators_spec_path
    @decorators_path ||= Pathname.new("#{tmp_path}/#{APP_NAME}/spec/decorators")
  end

  def decorators_test_path
    @decorators_path ||= Pathname.new("#{tmp_path}/#{APP_NAME}/test/decorators")
  end

  private

  def tmp_path
    @tmp_path ||= Pathname.new("#{root_path}/tmp")
  end

  def system_rails_bin
    "rails"
  end

  def project_rails_bin
    "bin/rails"
  end

  def root_path
    File.expand_path('../../../', __FILE__)
  end

  def with_env(name, new_value)
    had_key = ENV.has_key?(name)
    prior = ENV[name]
    ENV[name] = new_value.to_s

    yield

  ensure
    ENV.delete(name)

    if had_key
      ENV[name] = prior
    end
  end

  def run_in_tmp
    create_tmp_directory

    Dir.chdir(tmp_path) do
      Bundler.with_clean_env do
        yield
      end
    end
  end

  def run_in_project
    Dir.chdir(project_path) do
      Bundler.with_clean_env do
        yield
      end
    end
  end

  def debug(output)
    if ENV["DEBUG"]
      warn output
    end

    output
  end
end

RSpec.configure do |config|
  config.include GeneratorTestHelpers

  config.before(:each, type: :generator) do
    remove_project_directory
  end
end
