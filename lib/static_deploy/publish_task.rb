# frozen_string_literal: true

require "fileutils"
require "tty-prompt"

BUILD_DIR   = "_site"
ROOT        = `git rev-parse --show-toplevel`.strip
DEFAULT_URL = `git config --get remote.origin.url`.strip
REGEX       = /^.+:(.*)\/(.*).git$/

def prompt
  @prompt ||= TTY::Prompt.new
end

def default_user
  @default_user ||= DEFAULT_URL[REGEX, 1]
end

def default_repo
  @default_repo ||= DEFAULT_URL[REGEX, 2]
end

def generator
  @generator = ENV["GENERATOR"] || "jekyll"
end

def command
  @command = ENV["COMMAND"] || "build"
end

def has_git?
  sh "git --version"
  $?.success?
end

namespace :site do
  desc "Prepare remote branch"
  task :prepare, [:repo] do |t, args|
    prompt.ok "=> Preparing..."

    mkdir_p BUILD_DIR

    cd BUILD_DIR do
      unless File.exist?(".git")
        sh "git init"
        sh "git remote add github git@github.com:#{args.repo}.git"
        sh "git fetch github"
        `git ls-remote --exit-code git@github.com:#{args.repo}.git gh-pages`
        if $?.success?
          sh "git checkout -b gh-pages --track github/gh-pages"
        else
          `echo "text" > sample.txt`
          sh "git add sample.txt"
          sh "git commit -am 'Sample text'"
          sh "git checkout --orphan gh-pages"
        end
      end
    end
  end

  desc "Fetch upstream changes on gh pages"
  task :sync, [:repo] do |t, args|
    prompt.ok "=> Synching..."

    cd BUILD_DIR do
      sh "git fetch github"
      sh "git reset --hard github/gh-pages"
      # Remove old files
      sh "rm `git ls-files`"
    end
  end

  desc "Compile files into #{BUILD_DIR} directory"
  task :build do
    prompt.ok "=> Building..."

    cd ROOT do
      sh "bundle exec #{generator} #{command}"
    end
  end

  desc "Publish the website to GitHub pages"
  task :publish, [:repo] => [:prepare, :sync, :build] do |t, args|
    args.with_defaults(:repo => "#{default_user}/#{default_repo}")

    message = prompt.ask "Provide a deployment message for #{args.repo}: " do |q|
      q.required true
    end

    prompt.ok "=> Deploying to #{args.repo} GitHub Pages..."

    cd BUILD_DIR do
      sh "git add --all"
      if /nothing to commit/ =~ `git status`
        prompt.ok "No changes to commit."
      else
        sh "git commit -m '#{message.gsub("'", "\\'")}'"
      end
      sh "git push github gh-pages"
    end

    prompt.ok "Site build. OK"
  end
end
