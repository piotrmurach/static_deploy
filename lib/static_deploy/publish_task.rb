require 'fileutils'
require 'tty'

BUILD_DIR   = "_site"
ROOT        = `git rev-parse --show-toplevel`.strip
DEFAULT_URL = `git config --get remote.origin.url`.strip
REGEX       = /^.+:(.*)\/(.*).git$/

def shell
  @shell ||= TTY::Shell.new
end

def default_user
  @default_user ||= DEFAULT_URL[REGEX, 1]
end

def default_repo
  @default_repo ||= DEFAULT_URL[REGEX, 2]
end

def generator
  @generator = ENV['GENERATOR'] || 'jekyll'
end

def command
  @command = ENV['COMMAND'] || 'build'
end

namespace :site do
  desc "Prepare remote branch"
  task :prepare do |t, args|
    shell.say "=> Preparing...", color: :green

    mkdir_p BUILD_DIR

    cd BUILD_DIR do
      unless File.exists?(".git")
        sh "git init"
        sh "git remote add github git@github.com:#{args.repo}.git"
        sh "git fetch github"
        sh "git checkout -b gh-pages --track github/gh-pages"
      end
    end
  end

  desc "Fetch upstream changes on tty gh pages"
  task :sync do
    shell.say "=> Synching...", color: :green

    cd BUILD_DIR do
      sh "git fetch github"
      sh "git reset --hard github/gh-pages"
      # Remove old files
      sh "rm `git ls-files`"
    end
  end

  desc "Compile files into #{BUILD_DIR} directory"
  task :build do
    shell.say "=> Building...", color: :green

    cd ROOT do
      sh "bundle exec #{generator} #{command}"
    end
  end

  desc 'Publish the website to GitHub pages'
  task :publish, [:repo] => [:prepare, :sync, :build] do |t, args|
    args.with_defaults(:repo => "#{default_user}/#{default_repo}")

    message = shell.ask "Provide a deployment message for #{args.repo}: ", color: :green do
      argument :required
    end.read_string

    shell.say "=> Deploying to #{args.repo} GitHub Pages...", color: :green

    cd BUILD_DIR do
      sh 'git add --all'
      if /nothing to commit/ =~ `git status`
        shell.say "No changes to commit.", color: :green
      else
        sh "git commit -m '#{message.gsub("'", "\\'")}'"
      end
      sh "git push github gh-pages"
    end

    shell.say "Site build. OK", color: :green
  end
end
